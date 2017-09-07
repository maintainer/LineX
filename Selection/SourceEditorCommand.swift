//
//  SourceEditorCommand.swift
//  Selection
//
//  Created by Kaunteya Suryawanshi on 01/09/17.
//  Copyright © 2017 Kaunteya Suryawanshi. All rights reserved.
//

import Foundation
import XcodeKit

enum Options: String {
    case selectLine, oneSpace, expand, align
}

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        let buffer = invocation.buffer

        switch Options(command: invocation.commandIdentifier)! {
        case .selectLine:
            let range = buffer.selections.lastObject as! XCSourceTextRange
            range.start.column = 0
            range.end.line += 1
            range.end.column = 0

        case .oneSpace: //Does not work when caret is at end non white char
            let range = buffer.selections.lastObject as! XCSourceTextRange
            let currentLineOffset = range.start.line
            let currentLine = buffer.lines[currentLineOffset] as! String
            let pin = range.end.column
            let (newOffset, newLine) = currentLine.lineOneSpaceAt(pin: pin)
            buffer.lines.replaceObject(at: currentLineOffset, with: newLine)
            range.end.column = newOffset
            range.start.column = newOffset
        case .expand:
            break
        case .align:
            break
//            guard let indexSet = linesIndexSet(of: buffer) else {
//                print("indexSet is nil"); return
//            }
//            print("Indexset \(indexSet)")
//            let allLines = buffer.lines.objects(at: indexSet) as! [String]
        }
        completionHandler(nil)
    }
    
}
