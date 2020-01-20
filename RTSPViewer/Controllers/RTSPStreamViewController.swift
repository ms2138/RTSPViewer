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

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dragInteractionEnabled = true
        collectionView.dragDelegate = self
        collectionView.dropDelegate = self
    }
}

extension RTSPStreamViewController {
    func add(stream: URL) {
        videoStreams.append(stream)

        videoStreams.sort { $0.absoluteString < $1.absoluteString }

        if let index = self.videoStreams.firstIndex(of: stream) {
            let indexPath = IndexPath(row: index, section: 0)
            self.collectionView.insertItems(at: [indexPath])
            self.collectionView.reloadItems(at: [indexPath])
        }
    }
}

extension RTSPStreamViewController {
    // MARK: UICollectionViewDataSource

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
