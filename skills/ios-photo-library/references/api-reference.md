# Photo Library API Reference

## Pickers

### SwiftUI `PhotosPicker`

```swift
import PhotosUI

@State private var item: PhotosPickerItem?

PhotosPicker(selection: $item, matching: .images) {
    Label("Select Photo", systemImage: "photo")
}
.onChange(of: item) { _, newItem in
    Task {
        if let data = try? await newItem?.loadTransferable(type: Data.self) {
            // Decode image data
        }
    }
}
```

### UIKit `PHPickerViewController`

```swift
import PhotosUI

var config = PHPickerConfiguration(photoLibrary: .shared())
config.selectionLimit = 5
config.filter = .images
config.preferredAssetRepresentationMode = .automatic

let picker = PHPickerViewController(configuration: config)
picker.delegate = self
present(picker, animated: true)
```

## `PHPickerFilter`

| Filter | Use |
|---|---|
| `.images` | still images |
| `.videos` | videos |
| `.livePhotos` | Live Photos |
| `.any(of: [...])` | combined include set |
| `.all(of: [...])` | combined include/exclude set |
| `.not(...)` | exclusion filter |

```swift
config.filter = .all(of: [.images, .not(.screenshots)])
```

## `PHPickerViewControllerDelegate`

```swift
extension ViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)

        for result in results {
            let identifier = result.assetIdentifier

            result.itemProvider.loadObject(ofClass: UIImage.self) { object, _ in
                guard let image = object as? UIImage else { return }
                DispatchQueue.main.async {
                    self.display(image)
                }
            }
        }
    }
}
```

`PHPickerResult` fields:

| Property | Type | Notes |
|---|---|---|
| `itemProvider` | `NSItemProvider` | load selected asset |
| `assetIdentifier` | `String?` | requires `photoLibrary: .shared()` config |

## `PhotosPickerItem`

```swift
if let data = try? await item.loadTransferable(type: Data.self) {
    let image = UIImage(data: data)
}
```

```swift
struct PickedPhoto: Transferable {
    let image: UIImage

    static var transferRepresentation: some TransferRepresentation {
        DataRepresentation(importedContentType: .image) { data in
            guard let image = UIImage(data: data) else {
                throw CocoaError(.coderInvalidValue)
            }
            return PickedPhoto(image: image)
        }
    }
}
```

## Authorization

```swift
let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
let addOnlyStatus = PHPhotoLibrary.authorizationStatus(for: .addOnly)

let newStatus = await PHPhotoLibrary.requestAuthorization(for: .readWrite)
```

| Status | Meaning |
|---|---|
| `.notDetermined` | not requested yet |
| `.restricted` | parental/system restriction |
| `.denied` | user denied |
| `.limited` | subset of assets only |
| `.authorized` | full access |

## Limited Library APIs

```swift
PHPhotoLibrary.shared().presentLimitedLibraryPicker(from: viewController)
```

```swift
PHPhotoLibrary.shared().register(self)
PHPhotoLibrary.shared().unregisterChangeObserver(self)
```

## Saving to Library

```swift
try await PHPhotoLibrary.shared().performChanges {
    PHAssetCreationRequest.creationRequestForAsset(from: image)
}
```

```swift
try await PHPhotoLibrary.shared().performChanges {
    let request = PHAssetCreationRequest.forAsset()
    request.addResource(with: .photo, data: imageData, options: nil)
}
```

## Fetching Assets

```swift
let options = PHFetchOptions()
options.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
options.fetchLimit = 100

let assets = PHAsset.fetchAssets(with: .image, options: options)
```

| API | Purpose |
|---|---|
| `PHAsset.fetchAssets(with:options:)` | fetch by media type |
| `PHAsset.fetchAssets(in:options:)` | fetch in album/collection |
| `PHAsset.fetchAssets(withLocalIdentifiers:options:)` | restore known assets |
| `PHFetchResult` | lazy asset collection |

## Image Requests

```swift
let manager = PHImageManager.default()
manager.requestImage(
    for: asset,
    targetSize: CGSize(width: 300, height: 300),
    contentMode: .aspectFill,
    options: nil
) { image, info in
    // use image
}
```

## Info.plist Keys

```xml
<key>NSPhotoLibraryUsageDescription</key>
<string>Access photos you choose to share.</string>

<key>NSPhotoLibraryAddUsageDescription</key>
<string>Save exported images to your library.</string>
```
