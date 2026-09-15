$git = "C:\Program Files\Git\cmd\git.exe"
$gh  = "C:\Program Files\GitHub CLI\gh.exe"
$dir = "C:\Users\abhis\.gemini\antigravity\scratch\food-ordering-app-react-native"

Set-Location $dir

# ── 1. Remove old git history ──────────────────────────────────────────────────
Write-Host "Removing old .git history..."
Remove-Item -Recurse -Force ".git" -ErrorAction SilentlyContinue

# ── 2. Redact secrets in all google-service-account.json files ─────────────────
Write-Host "Redacting secrets..."
$jsonFiles = Get-ChildItem -Recurse -Filter "google-service-account.json"
foreach ($f in $jsonFiles) {
    $content = Get-Content $f.FullName -Raw
    # Replace anything between BEGIN PRIVATE KEY and END PRIVATE KEY (including those markers)
    $content = $content -replace '"private_key"\s*:\s*"-----BEGIN PRIVATE KEY-----[^"]*-----END PRIVATE KEY-----\\n"', '"private_key": "YOUR_GOOGLE_SERVICE_ACCOUNT_PRIVATE_KEY_HERE"'
    # Also handle escaped newlines variant
    $content = $content -replace '(?s)"private_key"\s*:\s*"[^"]*BEGIN PRIVATE KEY[^"]*"', '"private_key": "YOUR_GOOGLE_SERVICE_ACCOUNT_PRIVATE_KEY_HERE"'
    Set-Content $f.FullName $content -NoNewline
    Write-Host "  Redacted: $($f.FullName)"
}

# Redact Stripe test key placeholder
$stripeFile = "$dir\enatega-multivendor-admin\src\components\Configuration\Stripe\Stripe.jsx"
if (Test-Path $stripeFile) {
    $content = Get-Content $stripeFile -Raw
    $content = $content -replace 'sk_test_[A-Za-z0-9]+', 'sk_test_YOUR_STRIPE_KEY_HERE'
    Set-Content $stripeFile $content -NoNewline
    Write-Host "  Redacted Stripe key in Stripe.jsx"
}

# ── 3. Fresh git init ──────────────────────────────────────────────────────────
Write-Host "Initialising fresh git repo..."
& $git init
& $git config user.name  "Abhishek Bhagat"
& $git config user.email "abhishekb@users.noreply.github.com"
& $git add .
& $git commit -m "Initial commit: Food Delivery App"
& $git branch -M main
& $git remote add origin https://github.com/Abhishek-bhagat9/Food-Delivery-App.git

# ── 4. Configure credential helper via gh CLI and push ─────────────────────────
Write-Host "Setting up credentials and pushing..."
& $gh auth setup-git
& $git push -u origin main --force
Write-Host "DONE!"
