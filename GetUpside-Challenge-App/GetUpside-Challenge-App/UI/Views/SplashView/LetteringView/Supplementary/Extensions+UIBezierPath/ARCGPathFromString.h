#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Creates a CGPath from a specified attributed string.
 @param attrString The attributed string to produce the path for. Must not be `nil`.
 @return A new CGPath that contains a path with paths for all the glyphs for specifed string.
 @discussion  This string will always be on a single line even if the string contains linebreaks.
 */
CGPathRef CGPathCreateSingleLineStringWithAttributedString(NSAttributedString *attrString) CF_RETURNS_RETAINED;

/**
 Creates a CGPath from a specified attributed string that can span over multiple lines of text.
 @param attrString The attributed string to produce the path for. Must not be `nil`.
 @param maxWidth   The maximum width of a line, if a line when rendered is longer than this width then the line is broken to a new line. Must be greater than 0.
 @param maxHeight  The maximum height of the text block. Must be greater than 0.
 @return A new CGPath that contains a path with paths for all the glyphs for specifed string.
 */
CGPathRef CGPathCreateMultilineStringWithAttributedString(NSAttributedString *attrString, CGFloat maxWidth, CGFloat maxHeight) CF_RETURNS_RETAINED;


NS_ASSUME_NONNULL_END
