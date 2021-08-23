
Import-Module -Name $PSCommandPath.Replace('.tests.ps1', '.psm1')

$testCases = @(
    @{
        Ext  = '.png'
        Mime = 'image/png'
    }
    @{
        Ext  = '.json'
        Mime = 'application/json'
    }
    @{
        Ext  = '.txt'
        Mime = 'text/plain'
    }
    @{
        Ext  = '.mp3'
        Mime = 'audio/mpeg'
    }
)

Describe 'Get-MimeType' {

    It "'<Ext>' => '<Mime>'" -TestCases $testCases {
        param ($Ext, $Mime)

        Get-MimeType -Extension $Ext | Should -Be $Mime
    }

    It "'<Ext>' => '<Mime>' via Pipeline" -TestCases $testCases {
        param ($Ext, $Mime)

        $Ext | Get-MimeType | Should -Be $Mime
    }

}

Describe 'Get-Extension' {

    It "'<Ext>' => '<Mime>'" -TestCases $testCases {
        param ($Ext, $Mime)

        Get-Extension -MimeType $Mime | Should -Be $Ext
    }

    It "'<Ext>' => '<Mime>' via Pipeline" -TestCases $testCases {
        param ($Ext, $Mime)

        $Mime | Get-Extension | Should -Be $Ext
    }
}

Describe 'MimeTypeMap' {

    It "'<Ext>' => '<Mime>'" -TestCases $testCases {
        param ($Ext, $Mime)

        $MimeTypeMap[$Ext] | Should -Be $Mime
    }

    It "'<Mime>' => '<Ext>'" -TestCases $testCases {
        param ($Ext, $Mime)

        $MimeTypeMap[$Mime] | Should -Be $Ext
    }
}

Describe 'PwshMimeType' {
    It 'PSScirptAnalyzer pms1' {
        Invoke-ScriptAnalyzer -Path *.psm1 | Should -BeNullOrEmpty
    }

    It 'PSScirptAnalyzer ps1' {
        Invoke-ScriptAnalyzer -Path *.ps1 | Should -BeNullOrEmpty
    }
}
