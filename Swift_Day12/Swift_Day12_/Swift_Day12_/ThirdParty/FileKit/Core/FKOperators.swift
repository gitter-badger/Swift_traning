//
//  FKOperators.swift
//  FileKit
//
//  The MIT License (MIT)
//
//  Copyright (c) 2015 Nikolai Vazquez
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

// MARK: - FKFileType

infix operator |> {}

/// Writes data to a file.
///
/// - Throws: `FKError.WriteToFileFail`
///
public func |> <FileType: FKFileType>(data: FileType.DataType, file: FileType) throws {
    try file.write(data)
}



// MARK: - FKTextFile

infix operator |>> {}

/// Appends a string to a text file.
///
/// If the text file can't be read from, such in the case that it doesn't exist,
/// then it will try to write the data directly to the file.
///
/// - Throws: `FKError.WriteToFileFail`
///
//public func |>> (var data: String, file: FKTextFile) throws {
//    if let contents = try? file.read() {
//        data = contents + "\n" + data
//    }
//    try data |> file
//}



// MARK: - FKPath

/// Returns `true` if the standardized form of one path equals that of another path.
@warn_unused_result public func == (lhs: FKPath, rhs: FKPath) -> Bool {
    return lhs.standardized.rawValue == rhs.standardized.rawValue
}

/// Concatenates two `FKPath` instances and returns the result.
///
///     let systemLibrary: FKPath = "/System/Library"
///     print(systemLib + "Fonts")  // "/System/Library/Fonts"
///
public func + (lhs: FKPath, rhs: FKPath) -> FKPath {
    switch (lhs.rawValue.hasSuffix(FKPath.Separator), rhs.rawValue.hasPrefix(FKPath.Separator)) {
    case (true, true):
        return FKPath("\(lhs.rawValue)\(rhs.rawValue.substringFromIndex(rhs.rawValue.startIndex.successor()))")
    case (false, false):
        return FKPath("\(lhs.rawValue)\(FKPath.Separator)\(rhs.rawValue)")
    default:
        return FKPath("\(lhs.rawValue)\(rhs.rawValue)")
    }
}

/// Appends the right path to the left path.
public func += (inout lhs: FKPath, rhs: FKPath) {
    lhs = lhs + rhs
}


infix operator ->> {}

/// Moves the file at the left path to a path.
///
/// Throws an error if the file at the left path could not be moved or if a file
/// already exists at the right path.
///
/// - Throws:
///     - `FKError.FileDoesNotExist`,
///     - `FKError.MoveFileFail`
///
public func ->> (lhs: FKPath, rhs: FKPath) throws {
    try lhs.moveFileToPath(rhs)
}

/// Moves a file to a path.
///
/// Throws an error if the file could not be moved or if a file already
/// exists at the destination path.
///
/// - Throws:
///     - `FKError.FileDoesNotExist`,
///     - `FKError.MoveFileFail`
///
public func ->> <FileType: FKFileType>(inout lhs: FileType, rhs: FKPath) throws {
    try lhs.moveToPath(rhs)
}

infix operator ->! {}

/// Forcibly moves the file at the left path to the right path.
///
/// - Warning: If a file at the right path already exists, it will be deleted.
///
/// - Throws:
///     - `FKError.DeleteFileFail`,
///     - `FKError.FileDoesNotExist`,
///     - `FKError.CreateSymlinkFail`
///
public func ->! (lhs: FKPath, rhs: FKPath) throws {
    if rhs.exists {
        try rhs.deleteFile()
    }
    try lhs ->> rhs
}

/// Forcibly moves a file to a path.
///
/// - Warning: If a file at the right path already exists, it will be deleted.
///
/// - Throws:
///     - `FKError.DeleteFileFail`,
///     - `FKError.FileDoesNotExist`,
///     - `FKError.CreateSymlinkFail`
///
public func ->! <FileType: FKFileType>(inout lhs: FileType, rhs: FKPath) throws {
    if rhs.exists {
        try rhs.deleteFile()
    }
    try lhs ->> rhs
}


infix operator +>> {}

/// Copies the file at the left path to the right path.
///
/// Throws an error if the file at the left path could not be copied or if a file
/// already exists at the right path.
///
/// - Throws: `FKError.FileDoesNotExist`, `FKError.CopyFileFail`
///
public func +>> (lhs: FKPath, rhs: FKPath) throws {
    try lhs.copyFileToPath(rhs)
}

/// Copies a file to a path.
///
/// Throws an error if the file could not be copied or if a file already
/// exists at the destination path.
///
/// - Throws:
///     - `FKError.FileDoesNotExist`,
///     - `FKError.CopyFileFail`
///
public func +>> <FileType: FKFileType>(lhs: FileType, rhs: FKPath) throws {
    try lhs.copyToPath(rhs)
}

infix operator +>! {}

/// Forcibly copies the file at the left path to the right path.
///
/// - Warning: If a file at the right path already exists, it will be deleted.
///
/// - Throws:
///     - `FKError.DeleteFileFail`,
///     - `FKError.FileDoesNotExist`,
///     - `FKError.CreateSymlinkFail`
///
public func +>! (lhs: FKPath, rhs: FKPath) throws {
    if rhs.exists {
        try rhs.deleteFile()
    }
    try lhs +>> rhs
}

/// Forcibly copies a file to a path.
///
/// - Warning: If a file at the right path already exists, it will be deleted.
///
/// - Throws:
///     - `FKError.DeleteFileFail`,
///     - `FKError.FileDoesNotExist`,
///     - `FKError.CreateSymlinkFail`
///
public func +>! <FileType: FKFileType>(lhs: FileType, rhs: FKPath) throws {
    if rhs.exists {
        try rhs.deleteFile()
    }
    try lhs +>> rhs
}

infix operator =>> {}

/// Creates a symlink of the left path at the right path.
///
/// If the symbolic link path already exists and _is not_ a directory, an
/// error will be thrown and a link will not be created.
///
/// If the symbolic link path already exists and _is_ a directory, the link
/// will be made to a file in that directory.
///
/// - Throws:
///     - `FKError.FileDoesNotExist`,
///     - `FKError.CreateSymlinkFail`
///
public func =>> (lhs: FKPath, rhs: FKPath) throws {
    try lhs.symlinkFileToPath(rhs)
}

/// Symlinks a file to a path.
///
/// If the path already exists and _is not_ a directory, an error will be
/// thrown and a link will not be created.
///
/// If the path already exists and _is_ a directory, the link will be made
/// to the file in that directory.
///
/// - Throws: `FKError.FileDoesNotExist`, `FKError.CreateSymlinkFail`
///
public func =>> <FileType: FKFileType>(lhs: FileType, rhs: FKPath) throws {
    try lhs.symlinkToPath(rhs)
}

infix operator =>! {}

/// Forcibly creates a symlink of the left path at the right path by deleting
/// anything at the right path before creating the symlink.
///
/// - Warning: If the symbolic link path already exists, it will be deleted.
///
/// - Throws: 
///     - `FKError.DeleteFileFail`,
///     - `FKError.FileDoesNotExist`,
///     - `FKError.CreateSymlinkFail`
///
public func =>! (lhs: FKPath, rhs: FKPath) throws {
    if rhs.exists {
        try rhs.deleteFile()
    }
    try lhs =>> rhs
}

/// Forcibly creates a symlink of a file at a path by deleting anything at the
/// path before creating the symlink.
///
/// - Warning: If the path already exists, it will be deleted.
///
/// - Throws:
///     - `FKError.DeleteFileFail`,
///     - `FKError.FileDoesNotExist`,
///     - `FKError.CreateSymlinkFail`
///
public func =>! <FileType: FKFileType>(lhs: FileType, rhs: FKPath) throws {
    if rhs.exists {
        try rhs.deleteFile()
    }
    try lhs =>> rhs
}

postfix operator • {}

/// Returns the standardized version of the path.
///
/// Can be typed with alt+8.
///
@warn_unused_result public postfix func • (path: FKPath) -> FKPath {
    return path.standardized
}


postfix operator ^ {}

/// Returns the path's parent path.
@warn_unused_result public postfix func ^ (path: FKPath) -> FKPath {
    return path.parent
}



