InModuleScope PixooPS {
    Describe "Test Find-Pixoo" {
        Context "Known IP Address" {
            $MockPixooIP = "192.168.1.199"
            Find-Pixoo -IPAddress $MockPixooIP | Should -BeLike $MockPixooIP
        }
        Context "Unknown IP Address" {
            Find-Pixoo | Should -BeNullOrEmpty
        }
    } -Skip:$(if ($env:PSGALLERY_API_KEY) { $false }else { $true })
    # Skip if we are running under CI, CI shouldn't have PSGALLERY_API_KEY set.
}
