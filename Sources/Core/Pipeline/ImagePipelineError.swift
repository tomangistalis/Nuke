// The MIT License (MIT)
//
// Copyright (c) 2015-2022 Alexander Grebenyuk (github.com/kean).

import Foundation

extension ImagePipeline {
    /// Represents all possible image pipeline errors.
    public enum Error: Swift.Error, CustomStringConvertible {
        /// Returned if data not cached and `.returnCacheDataDontLoad` option is specified.
        case dataMissingInCache
        /// Data loader failed to load image data with a wrapped error.
        case dataLoadingFailed(Swift.Error)
        /// Data loader returned empty data.
        case dataIsEmpty
        /// No decoder registered for the given data.
        case decoderNotRegistered(context: ImageDecodingContext)
        /// Decoder failed to produce a final image.
        case decodingFailed(Data)
        /// Processor failed to produce a final image.
        case processingFailed(ImageProcessing)

        public var description: String {
            switch self {
            case .dataMissingInCache:
                return "Failed to load data from cache and download is disabled."
            case let .dataLoadingFailed(error):
                return "Failed to load image data: \(error)"
            case .dataIsEmpty:
                return "Data loader returned empty data."
            case .decoderNotRegistered:
                return "No decoders registered for the downloaded data."
            case .decodingFailed:
                return "Failed to create an image from the image data"
            case .processingFailed(let processor):
                return "Failed to process the image using processor \(processor)"
            }
        }

        /// Returns underlying data loading error.
        public var dataLoadingError: Swift.Error? {
            switch self {
            case .dataLoadingFailed(let error):
                return error
            default:
                return nil
            }
        }
    }
}