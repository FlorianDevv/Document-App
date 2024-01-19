//
//  DocumentTableViewController.swift
//  Document App
//
//  Created by Florian PICHON on 17/01/2024.
//

 
  /*  static let document: [DocumentFile] = [
        DocumentFile(title: "Document 1", size: 100, imageName: nil, url: URL(string: "https://www.apple.com")!, type: "text/plain"),
        DocumentFile(title: "Document 2", size: 200, imageName: nil, url: URL(string: "https://www.apple.com")!, type: "text/plain"),
            DocumentFile(title: "Document 3", size: 300, imageName: nil, url: URL(string: "https://www.apple.com")!, type: "text/plain"),
            DocumentFile(title: "Document 4", size: 400, imageName: nil, url: URL(string: "https://www.apple.com")!, type: "text/plain"),
            DocumentFile(title: "Document 5", size: 500, imageName: nil, url: URL(string: "https://www.apple.com")!, type: "text/plain"),
            DocumentFile(title: "Document 6", size: 600, imageName: nil, url: URL(string: "https://www.apple.com")!, type: "text/plain"),
            DocumentFile(title: "Document 7", size: 700, imageName: nil, url: URL(string: "https://www.apple.com")!, type: "text/plain"),
            DocumentFile(title: "Document 8", size: 800, imageName: nil, url: URL(string: "https://www.apple.com")!, type: "text/plain"),
            DocumentFile(title: "Document 9", size: 900, imageName: nil, url: URL(string: "https://www.apple.com")!, type: "text/plain"),
            DocumentFile(title: "Document 10", size: 1000, imageName: nil, url: URL(string: "https://www.apple.com")!, type: "text/plain"),

    ] */

import UIKit
import QuickLook
import UniformTypeIdentifiers
extension Int {
    func formattedSize() -> String {
        let byteCountFormatter = ByteCountFormatter()
        return byteCountFormatter.string(fromByteCount: Int64(self))
    }
}

class DocumentTableViewController: UITableViewController, QLPreviewControllerDataSource, UIDocumentPickerDelegate {

var selectedIndex: Int = 0
    var documents: [DocumentFile] = []
    var previewController = QLPreviewController()
    var bundleDocuments: [DocumentFile] = []
    var importedDocuments: [DocumentFile] = []
    struct DocumentFile {
        var title: String
        var size: Int
        var imageName: String? = nil
        var url: URL
        var type: String
    }
    
    func listFileInBundle() -> [DocumentFile] {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        var documentListBundle = [DocumentFile]()
    
        for item in items {
            if !item.hasSuffix("DS_Store") && item.hasSuffix(".jpg") {
                let currentUrl = URL(fileURLWithPath: path + "/" + item)
                let resourcesValues = try! currentUrl.resourceValues(forKeys: [.contentTypeKey, .nameKey, .fileSizeKey])
                   
                documentListBundle.append(DocumentFile(
                    title: resourcesValues.name!,
                    size: resourcesValues.fileSize ?? 0,
                    imageName: item,
                    url: currentUrl,
                    type: resourcesValues.contentType!.description)
                )
            }
        }
        return documentListBundle
    }

    override func viewDidLoad() {
            super.viewDidLoad()
            bundleDocuments = listFileInBundle()
            importedDocuments = listFileInDocumentsDirectory()
            tableView.reloadData()
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addDocument))
        }
    @objc func addDocument() {
            let documentTypes = [UTType.image]
            let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: documentTypes)
            documentPicker.delegate = self
            present(documentPicker, animated: true, completion: nil)
        }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let url = urls.first else { return }
        copyFileToDocumentsDirectory(fromUrl: url)
        // Reload the documents
        importedDocuments = listFileInDocumentsDirectory()
        let indexSet = IndexSet(integer: 1) // Section 1 is the "Importations" section
        tableView.reloadSections(indexSet, with: .automatic)
    }
    
    func copyFileToDocumentsDirectory(fromUrl url: URL) {
            let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let destinationUrl = documentsDirectory.appendingPathComponent(url.lastPathComponent)
            do {
                try FileManager.default.copyItem(at: url, to: destinationUrl)
            } catch {
                print(error)
            }
        }

    func listFileInDocumentsDirectory() -> [DocumentFile] {
            let fm = FileManager.default
            let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path
            let items = try! fm.contentsOfDirectory(atPath: path)
            
            var documentList = [DocumentFile]()
        
            for item in items {
                if !item.hasSuffix("DS_Store") {
                    let currentUrl = URL(fileURLWithPath: path + "/" + item)
                    let resourcesValues = try! currentUrl.resourceValues(forKeys: [.contentTypeKey, .nameKey, .fileSizeKey])
                       
                    documentList.append(DocumentFile(
                        title: resourcesValues.name!,
                        size: resourcesValues.fileSize ?? 0,
                        imageName: item,
                        url: currentUrl,
                        type: resourcesValues.contentType!.description)
                    )
                }
            }
            return documentList
        }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if section == 0 {
                return bundleDocuments.count
            } else {
                return importedDocuments.count
            }
        }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        previewController.dataSource = self
        if indexPath.section == 0 {
            selectedIndex = indexPath.row
        } else {
            selectedIndex = indexPath.row + bundleDocuments.count
        }
        previewController.currentPreviewItemIndex = selectedIndex
        present(previewController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentCell", for: indexPath)
            let document = (indexPath.section == 0) ? bundleDocuments[indexPath.row] : importedDocuments[indexPath.row]
            cell.textLabel?.text = document.title
            cell.detailTextLabel?.text = "\(document.size.formattedSize())"
            cell.accessoryType = .disclosureIndicator
            return cell
        }

        override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            if section == 0 {
                return "Bundles"
            } else {
                return "Importations"
            }
        }
    
    func instantiateQLPreviewController(withUrl url: URL) {
        previewController.dataSource = self
        present(previewController, animated: true, completion: nil)
    }
    
    // MARK: - QLPreviewControllerDataSource
    
    func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return bundleDocuments.count + importedDocuments.count
    }
        
    func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        if index < bundleDocuments.count {
            return bundleDocuments[index].url as QLPreviewItem
        } else {
            return importedDocuments[index - bundleDocuments.count].url as QLPreviewItem
        }
    }
}
