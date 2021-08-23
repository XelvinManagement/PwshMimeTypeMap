# PwshMimeTypeMap

## Summary
Provides a huge two-way mapping of file extensions to mime types and mime types to file extensions, e.g.:

```PowerShell
@{
    '.jpe'  = 'image/jpeg'
    '.jpeg' = 'image/jpeg'
    '.jpg'  = 'image/jpeg'
    '.js'   = 'application/javascript'
    '.json' = 'application/json'
}
```

Most mime types that have multiple possible extensions are pre-defined to get the most common extension when looking up extension by mime type.
Since multiple extensions can map to the same mime type, it is not necessary that
`$ext | Get-MimeType | Get-Extension` returns the original extension.
It will return the most common extension.

Original C# version here: <https://github.com/samuelneff/MimeTypeMap>

## Collaboration

Please submit pull requests for any additions. Thanks!

## Usage

This all in one module file is designed to be added to any other PowerShell module as a nested module.
Just put `PwshMimeTypeMap.psm1` in your modules root folder and add the following to your module manifest:

```PowerShell
NestedModules = @('./PwshMimeTypeMap.psm1')
```

### Getting the mime type to an extension

```PowerShell
Get-MimeType -Extension 'txt'
'txt' | Get-MimeType
$MimeTypeMap['txt']
# text/plain
```

Pass in a string extension and get a mime type back. Optionally include the period.
If not it will be added before looking up the mime type.

If no mime type is found then the generic "application/octet-stream" is returned.

### Getting the extension to a mime type

```PowerShell
Get-Extension -MimeType 'audio/wav'
'audio/wav' | Get-Extension
$MimeTypeMap['audio/wav']
# .wav
```

Pass in a mime type and get an extension back.

If the mime type is not registered, `$null` is returned.
Optionally provide the `-ThrowIfNotFound` switch to throw an error for unregistered mime types.

