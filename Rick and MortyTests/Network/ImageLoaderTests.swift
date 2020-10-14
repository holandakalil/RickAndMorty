//
//  ImageLoaderTests.swift
//  Rick and MortyTests
//
//  Created by Kalil Holanda on 13/10/20.
//

import XCTest
@testable import Rick_and_Morty

class ImageLoaderTests: XCTestCase {
    
    var sut: ImageLoader!

    override func setUp() {
        sut = ImageLoader()
    }

    override func tearDown() {
        sut = nil
    }
    
    func testImageLoader_GetImage_ReturnSuccess() {
        // Arrange
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg") else {
            XCTAssertNotNil(nil, "Bad url")
            return
        }
        let expectation = self.expectation(description: "ImageLoader loadImage Response Expectation")
        
        // Act
        let _ = sut.loadImage(url) { (result) in
            
            // Assert
            let resultImage = try? result.get()
            
            XCTAssertNotNil(resultImage, "Expected to return image")
            
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
    }
    
    func testImageLoader_GetImage_ReturnNil() {
        // Arrange
        guard let url = URL(string: "https://12345678.com/api/character/avatar/1.jpeg") else {
            XCTAssertNotNil(nil, "Bad url")
            return
        }
        let expectation = self.expectation(description: "ImageLoader loadImage Response Expectation")
        
        // Act
        let _ = sut.loadImage(url) { (result) in
            
            // Assert
            switch result {
                case .success(let image):
                    XCTAssertNil(image, "Expected to not return image")
                case .failure(let error):
                    XCTAssertNotNil(error, "Expected to return error")
            }
            
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5)
    }
}
