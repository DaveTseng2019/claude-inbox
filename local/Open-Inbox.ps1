# 開啟收件匣網頁：先確定服務在跑，再用預設瀏覽器開帶權杖的完整網址。
# 網址每次從 ~/.claude-inbox/config.json 現讀，換埠、換權杖、換位址都不用改捷徑。
# 權杖不寫進捷徑，也不印到任何地方。
$ErrorActionPreference = 'Stop'
# 本機修改（非上游）：桌面「收件匣」捷徑用這支腳本。路徑相對於本檔，repo 搬家也不用改。
$py = Join-Path (Split-Path $PSScriptRoot -Parent) 'inbox\inbox.py'
try {
    # inbox.py start：服務沒在跑就在背景啟動，成功時最後一行是完整網址。
    $url = (& python $py start 2>$null | Select-Object -Last 1)
    if ($url -and $url.Trim() -match '^https?://') {
        Start-Process $url.Trim()
    } else {
        throw 'start-failed'
    }
} catch {
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.MessageBox]::Show(
        "收件匣的服務起不來。`n請確認 Tailscale 已連線，再看 %USERPROFILE%\.claude-inbox\server.log。",
        '收件匣', 'OK', 'Warning') | Out-Null
}
