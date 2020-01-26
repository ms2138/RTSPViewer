//
//  RTSPStreamViewController.swift
//  RTSPViewer
//
//  Created by mani on 2019-12-26.
//  Copyright © 2019 mani. All rights reserved.
//

import UIKit

private let reuseIdentifier = "RTSPStreamCell"

class RTSPStreamViewController: UICollectionViewController {

    private var videoStreams = [URL]()
    private var deleteButtonItem: UIBarButtonItem!
    @IBOutlet weak var selectionModeButtonItem: UIBarButtonItem!
    var isSelecting: Bool = false {
        didSet {
            collectionView.allowsMultipleSelection = isSelecting
            navigationController?.setToolbarHidden(!isSelecting, animated: true)

            updateInterfaceForSelectionMode()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dragInteractionEnabled = true
        collectionView.dragDelegate = self
        collectionView.dropDelegate = self

        deleteButtonItem = UIBarButtonItem(barButtonSystemItem: .trash,
                                           target: self,
                                           action: #selector(deleteSelectedItems))
        deleteButtonItem.isEnabled = false

        setToolbarItems([deleteButtonItem], animated: true)

        title = "Live View"
    }
}

extension RTSPStreamViewController {
    // MARK: - Adding and deleting streams

    func add(stream: URL) {
        videoStreams.append(stream)

        videoStreams.sort { $0.absoluteString < $1.absoluteString }

        if let index = self.videoStreams.firstIndex(of: stream) {
            let indexPath = IndexPath(row: index, section: 0)
            self.collectionView.insertItems(at: [indexPath])
            self.collectionView.reloadItems(at: [indexPath])
        }
    }

    @objc func deleteSelectedItems() {
        if let selectedPaths = collectionView.indexPathsForSelectedItems {
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [unowned self] _ in
                self.deleteItems(at: selectedPaths)
                self.updateInterfaceForSelectionMode()
            }

            alertController.addAction(cancelAction)
            alertController.addAction(deleteAction)

            present(alertController, animated: true)
        }
    }

    func deleteItems(at indexPaths: [IndexPath]) {
        var deleteVideoStreams = [URL]()
        indexPaths.forEach { indexPath in
            deleteVideoStreams.append(videoStreams[indexPath.row])
        }

        videoStreams.removeElements(in: deleteVideoStreams)

        collectionView.performBatchUpdates({
            self.collectionView.deleteItems(at: indexPaths)
        }, completion: nil)

        if videoStreams.count == 0 {
            toggleSelection()
        }
    }
}

extension RTSPStreamViewController {
    // MARK: - Item Selection

    @IBAction func toggleSelection() {
        if isSelecting == true {
            selectionModeButtonItem.title = "Select"
            collectionView.deselectAllItems(animated: true)
            isSelecting = false
        } else {
            selectionModeButtonItem.title = "Cancel"
            isSelecting = true
        }
    }

    func updateInterfaceForSelectionMode() {
        guard let selectedPaths = collectionView.indexPathsForSelectedItems else {
            return
        }
        
        let enableButtonItem = (selectedPaths.count > 0)
        deleteButtonItem.isEnabled = enableButtonItem

        switch selectedPaths.count {
        case let selectionCount where selectionCount == 1:
            title = "\(selectedPaths.count) item selected"
        case let selectionCount where selectionCount > 1:
            title = "\(selectedPaths.count) items selected"
        default:
            title = isSelecting ? "Select Items" : "Live View"
        }
    }
}

extension RTSPStreamViewController {
    // MARK: Collection view data source

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoStreams.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! VideoCell

        let videoStreamURL = videoStreams[indexPath.row]
        cell.playStream(at: videoStreamURL)

        return cell
    }
}

extension RTSPStreamViewController {
    // MARK: - Collection view delegate

    override func collectionView(_ collectionView: UICollectionView,
                                 shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard isSelecting else { return }

        updateInterfaceForSelectionMode()
    }

    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard isSelecting else { return }

        updateInterfaceForSelectionMode()
    }
}

extension RTSPStreamViewController: UICollectionViewDelegateFlowLayout {
    // MARK: - Collection view flow layout delegate

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellDimensions = CGSize(width: view.frame.width / 2,
                                    height: view.frame.width / 2)
        return cellDimensions
    }
}

extension RTSPStreamViewController: UICollectionViewDragDelegate {
    // MARK: - Collection view drag delegate

    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession,
                        at indexPath: IndexPath) -> [UIDragItem] {
        let url = videoStreams[indexPath.row]

        let itemProvider = NSItemProvider(object: url as NSURL)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        return [dragItem]
    }
}

extension RTSPStreamViewController: UICollectionViewDropDelegate {
    // MARK: - Collection view drop delegate

    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
        return true
    }

    func collectionView(_ collectionView: UICollectionView,
                        performDropWith coordinator: UICollectionViewDropCoordinator) {
        guard let destinationIndexPath = coordinator.destinationIndexPath else {
            return
        }

        coordinator.items.forEach { dropItem in
            guard let sourceIndexPath = dropItem.sourceIndexPath else {
                return
            }

            collectionView.performBatchUpdates({
                let toMoveStream = videoStreams.remove(at: sourceIndexPath.row)
                videoStreams.insert(toMoveStream, at: destinationIndexPath.row)

                collectionView.deleteItems(at: [sourceIndexPath])
                collectionView.insertItems(at: [destinationIndexPath])
            }, completion: { _ in
                coordinator.drop(dropItem.dragItem,
                                 toItemAt: destinationIndexPath)
            })
        }
    }

    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession,
                        withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        if collectionView.hasActiveDrag {
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UICollectionViewDropProposal(operation: .forbidden)
    }
}

extension RTSPStreamViewController {
    // MARK: - Segue

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "addStream":
            addStream(for: segue)
        default:
            preconditionFailure("Segue identifier did not match")
        }
    }

    private func addStream(for segue: UIStoryboardSegue) {
        guard let navController = segue.destination as? UINavigationController else { return }
        guard let topController = navController.topViewController else { return }
        guard let viewController = topController as? AddStreamViewController else { return }

        viewController.handler = { [unowned self] (url) in
            self.add(stream: url)
        }
    }
}
