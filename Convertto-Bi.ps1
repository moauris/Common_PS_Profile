Param(
    [int]$int1
)
$moduler
$reminder = $int1
$res

do {
    $moduler = $reminder % 2
    $reminder = ($reminder - $moduler) / 2
    $res = [string] $res + $moduler
}
until($reminder = 0)
$res