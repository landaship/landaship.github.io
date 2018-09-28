# CFError 如何获取错误信息

https://developer.apple.com/reference/corefoundation/1667016-cferror

Getting Information About an Error

func CFErrorGetDomain(CFError!)
Returns the error domain for a given CFError.
func CFErrorGetCode(CFError!)
Returns the error code for a given CFError.
func CFErrorCopyUserInfo(CFError!)
Returns the user info dictionary for a given CFError.
func CFErrorCopyDescription(CFError!)
Returns a human-presentable description for a given error.
func CFErrorCopyFailureReason(CFError!)
Returns a human-presentable failure reason for a given error.
func CFErrorCopyRecoverySuggestion(CFError!)

Returns a human presentable recovery suggestion for a given error.

