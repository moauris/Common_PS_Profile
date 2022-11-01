Param (
   [Parameter(Mandatory=$false)]
   [string] $Path = ".\"
)


function sumFileSize($Path)
{
    [int]$sum = 0
    foreach($f in $(Get-ChildItem -Path $Path -File))
    {
        $sum += $f.length
    }

    $Dir = Get-ChildItem -Path $Path -Directory

    if($null -ne $Dir) {
        foreach($d in $Dir)
        {
            $sum += sumFileSize($d.FullName)
        }
        return $sum
    }
}


sumFileSize($Path)

 