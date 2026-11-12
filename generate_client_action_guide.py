import os
import subprocess
import pypdf

root_dir = os.path.dirname(os.path.abspath(__file__))
output_html = os.path.join(root_dir, "Trouble_Cheat_Client_Setup_Guide_Functions_and_Maps.html")
output_pdf = os.path.join(root_dir, "Trouble_Cheat_Client_Setup_Guide_Functions_and_Maps.pdf")
artifact_pdf = "/Users/muhammadshaheertariq/.gemini/antigravity/brain/ca26fcdc-d72c-431d-b583-4fbb92364283/Trouble_Cheat_Client_Setup_Guide_Functions_and_Maps.pdf"

html_content = """<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Client Action Guide: Cloud Functions & Google Maps APIs Setup</title>
<style>
  @page {
    size: letter;
    margin: 9mm 12mm 9mm 12mm;
  }

  * {
    box-sizing: border-box;
  }

  body {
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
    color: #1e293b;
    line-height: 1.4;
    font-size: 8.5pt;
    margin: 0;
    padding: 0;
    background-color: #ffffff;
  }

  .page-container {
    height: 260mm;
    max-height: 260mm;
    position: relative;
    page-break-after: always;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
  }

  .page-container:last-child {
    page-break-after: avoid;
  }

  /* Header */
  .header-container {
    border-bottom: 2px solid #0f172a;
    padding-bottom: 6px;
    margin-bottom: 8px;
  }

  .app-badge {
    display: inline-block;
    font-size: 7.2pt;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 1.1px;
    color: #0369a1;
    background-color: #e0f2fe;
    padding: 2px 7px;
    border-radius: 4px;
    margin-bottom: 4px;
    border: 1px solid #bae6fd;
  }

  .doc-title {
    font-size: 14.5pt;
    font-weight: 800;
    color: #0f172a;
    margin: 0 0 2px 0;
    letter-spacing: -0.3px;
  }

  .doc-subtitle {
    font-size: 8.8pt;
    color: #64748b;
    margin: 0;
  }

  /* Meta table */
  .meta-grid {
    display: grid;
    grid-template-columns: 1.2fr 1.6fr 1.3fr 1.1fr;
    gap: 6px;
    background-color: #f8fafc;
    border: 1px solid #e2e8f0;
    border-radius: 6px;
    padding: 6px 10px;
    margin-bottom: 9px;
  }

  .meta-item {
    font-size: 7.8pt;
  }

  .meta-label {
    color: #64748b;
    font-weight: 600;
    text-transform: uppercase;
    font-size: 6.6pt;
    margin-bottom: 1px;
  }

  .meta-value {
    color: #0f172a;
    font-weight: 700;
  }

  .meta-value code {
    background: #e2e8f0;
    padding: 1px 4px;
    border-radius: 3px;
    font-size: 7.2pt;
    font-family: ui-monospace, Menlo, Monaco, monospace;
    white-space: nowrap;
  }

  /* Notice Callout */
  .intro-box {
    background-color: #f8fafc;
    border-left: 3.5px solid #0284c7;
    padding: 7px 10px;
    border-radius: 0 5px 5px 0;
    margin-bottom: 9px;
    font-size: 8.2pt;
    color: #334155;
  }

  /* Section styles */
  .section-title {
    font-size: 10pt;
    font-weight: 700;
    color: #0f172a;
    margin: 0 0 5px 0;
    display: flex;
    align-items: center;
    gap: 6px;
  }

  .section-title::before {
    content: "";
    display: inline-block;
    width: 4px;
    height: 12px;
    background: #0284c7;
    border-radius: 2px;
  }

  /* Step Card */
  .step-card {
    background: #ffffff;
    border: 1px solid #cbd5e1;
    border-radius: 6px;
    padding: 8px 12px;
    margin-bottom: 9px;
    box-shadow: 0 1px 2px rgba(0,0,0,0.02);
  }

  .step-card-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 4px;
  }

  .step-card-title {
    font-size: 9.3pt;
    font-weight: 700;
    color: #0f172a;
    margin: 0;
  }

  .time-tag {
    font-size: 6.8pt;
    font-weight: 700;
    text-transform: uppercase;
    padding: 2px 5px;
    border-radius: 3px;
    background: #f1f5f9;
    color: #475569;
    border: 1px solid #e2e8f0;
  }

  .action-list {
    margin: 0;
    padding-left: 17px;
    color: #334155;
  }

  .action-list li {
    margin-bottom: 4px;
    line-height: 1.35;
  }

  .action-list li:last-child {
    margin-bottom: 0;
  }

  .url-badge {
    display: inline-block;
    background: #f1f5f9;
    border: 1px solid #cbd5e1;
    padding: 1px 5px;
    border-radius: 3px;
    font-size: 7.3pt;
    font-family: ui-monospace, Menlo, Monaco, monospace;
    color: #0284c7;
    word-break: break-all;
  }

  .warning-box {
    background: #fffbeb;
    border: 1px solid #fef3c7;
    border-left: 3.5px solid #d97706;
    border-radius: 0 4px 4px 0;
    padding: 5px 9px;
    margin-top: 5px;
    font-size: 7.8pt;
    color: #92400e;
  }

  /* Dual Access Box */
  .access-box {
    background: #f8fafc;
    border: 1px solid #e2e8f0;
    border-radius: 5px;
    padding: 6px 9px;
    margin: 5px 0 7px 0;
  }

  .access-row {
    display: flex;
    align-items: baseline;
    gap: 7px;
    margin-bottom: 5px;
    font-size: 7.7pt;
    line-height: 1.35;
  }

  .access-row:last-child {
    margin-bottom: 0;
  }

  .access-tag {
    font-size: 6.6pt;
    font-weight: 800;
    text-transform: uppercase;
    padding: 2px 5px;
    border-radius: 3px;
    white-space: nowrap;
    flex-shrink: 0;
  }

  .access-tag.primary {
    background: #0284c7;
    color: #ffffff;
  }

  .access-tag.secondary {
    background: #475569;
    color: #ffffff;
  }

  .access-desc {
    color: #334155;
    flex: 1;
  }

  .highlight-table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 6px;
    font-size: 7.8pt;
  }

  .highlight-table th {
    background: #f1f5f9;
    color: #334155;
    font-weight: 700;
    text-align: left;
    padding: 5px 7px;
    border: 1px solid #cbd5e1;
  }

  .highlight-table td {
    padding: 5px 7px;
    border: 1px solid #cbd5e1;
    color: #0f172a;
  }

  /* Deliverables box */
  .deliverables-container {
    background: #f0fdf4;
    border: 1.5px solid #86efac;
    border-radius: 6px;
    padding: 9px 12px;
    margin-top: 8px;
  }

  .deliverable-item {
    display: flex;
    align-items: flex-start;
    gap: 7px;
    margin-bottom: 4px;
    font-size: 8.1pt;
    color: #14532d;
  }

  .deliverable-item:last-child {
    margin-bottom: 0;
  }

  .checkbox-icon {
    font-weight: bold;
    color: #16a34a;
    font-size: 9.5pt;
  }

  /* Footer */
  .doc-footer {
    border-top: 1px solid #e2e8f0;
    padding-top: 4px;
    font-size: 7.2pt;
    color: #94a3b8;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }
</style>
</head>
<body>

  <!-- ==================== PAGE 1 ==================== -->
  <div class="page-container">
    <div>
      <div class="header-container">
        <div class="app-badge">Project Owner Action Guide • Configuration Checklist</div>
        <h1 class="doc-title">Enabling Cloud Functions & Google Maps APIs</h1>
        <p class="doc-subtitle">Trouble-Cheat Security App • Step-by-Step Instructions for the Project Owner</p>
      </div>

      <div class="meta-grid">
        <div class="meta-item">
          <div class="meta-label">Project Name</div>
          <div class="meta-value">Trouble-Cheat Security</div>
        </div>
        <div class="meta-item">
          <div class="meta-label">Firebase Project ID</div>
          <div class="meta-value"><code>trouble-cheat-security-app</code></div>
        </div>
        <div class="meta-item">
          <div class="meta-label">Action Required By</div>
          <div class="meta-value">Project Owner</div>
        </div>
        <div class="meta-item">
          <div class="meta-label">Estimated Time</div>
          <div class="meta-value" style="color: #0284c7;">~3–5 Minutes</div>
        </div>
      </div>

      <div class="intro-box">
        <strong>Overview for the Owner:</strong><br>
        To preserve your project ownership while allowing our engineering team to proceed with mobile development, please complete the following setup steps. Both <strong>direct browser links (Option A)</strong> and <strong>Firebase Console navigation paths (Option B)</strong> are provided below so you can use whichever method is easiest.
      </div>

      <!-- PART 1 -->
      <div class="section-title">Part 1: Initialize Firebase Cloud Functions (1 Minute)</div>
      <div class="step-card">
        <div class="step-card-header">
          <h3 class="step-card-title">Step 1: One-Click Cloud Functions Activation</h3>
          <span class="time-tag">~60 SECONDS</span>
        </div>
        <p style="margin: 0 0 4px 0; color: #475569; font-size: 8pt;">
          <strong>Purpose:</strong> Powers automated 24/7 Safety Timers and emergency contact notification webhooks. Firebase requires the Project Owner to perform the initial setup once.
        </p>

        <div class="access-box">
          <div class="access-row">
            <span class="access-tag primary">Option A • Direct Link</span>
            <span class="access-desc">Open directly in browser: <span class="url-badge">https://console.firebase.google.com/project/trouble-cheat-security-app/functions</span></span>
          </div>
          <div class="access-row">
            <span class="access-tag secondary">Option B • Via Firebase</span>
            <span class="access-desc">Open <strong>Firebase Console</strong> &rarr; Select <strong>Trouble-Cheat Security App</strong> &rarr; In left sidebar, click <strong>Build</strong> (or <em>Hosting & Serverless</em>) &rarr; <strong>Functions</strong>.</span>
          </div>
        </div>

        <ol class="action-list" style="margin-top: 4px;">
          <li>Click the prominent <strong>"Get started"</strong> (or <strong>"Set up Functions"</strong>) button displayed on the page.</li>
          <li>Follow the brief on-screen prompt confirming the default region (e.g., <code>us-central1</code>) and click <strong>Finish / Done</strong>.</li>
        </ol>
        <div class="warning-box">
          <strong>Note:</strong> Once this initial button click is completed, our development team will be able to deploy all backend functions directly via the CLI without bothering you again.
        </div>
      </div>

      <!-- PART 2 -->
      <div class="section-title" style="margin-top: 9px;">Part 2: Enable Google Maps APIs on Google Cloud (2 Minutes)</div>
      <div class="step-card">
        <div class="step-card-header">
          <h3 class="step-card-title">Step 2: Enable the Required Location & Map SDKs</h3>
          <span class="time-tag">~2 MINUTES</span>
        </div>
        <p style="margin: 0 0 4px 0; color: #475569; font-size: 8pt;">
          <strong>Purpose:</strong> Live incident tracking, GPS breadcrumbs, and location radar require Google Maps services to be turned on in Google Cloud for this project.
        </p>

        <div class="access-box">
          <div class="access-row">
            <span class="access-tag primary">Option A • Direct Link</span>
            <span class="access-desc">Open API Library directly: <span class="url-badge">https://console.cloud.google.com/apis/library?project=trouble-cheat-security-app</span></span>
          </div>
          <div class="access-row">
            <span class="access-tag secondary">Option B • Via Firebase</span>
            <span class="access-desc">In Firebase Console &rarr; Click <strong>Project Settings (gear icon)</strong> &rarr; <strong>Users and permissions</strong> tab &rarr; Click <strong>"Advanced permission settings"</strong> (or click the GCP link in <em>General</em> tab) to enter Google Cloud &rarr; In Google Cloud, click <strong>☰ Menu</strong> &rarr; <strong>APIs & Services</strong> &rarr; <strong>Library</strong>.</span>
          </div>
        </div>

        <p style="margin: 5px 0 2px 0; font-weight: 700; color: #0f172a; font-size: 8pt;">Enable the 3 Required Services in the Library:</p>
        <ol class="action-list">
          <li>Search for <strong>"Maps SDK for Android"</strong> &rarr; Click on it &rarr; Click the blue <strong>ENABLE</strong> button.</li>
          <li>Return to the library, search for <strong>"Maps SDK for iOS"</strong> &rarr; Click on it &rarr; Click the blue <strong>ENABLE</strong> button.</li>
          <li>Search for <strong>"Geocoding API"</strong> &rarr; Click on it &rarr; Click the blue <strong>ENABLE</strong> button <em>(required to convert GPS coordinates into readable street addresses during an SOS)</em>.</li>
        </ol>
      </div>

    </div>

    <div class="doc-footer">
      <span>Trouble-Cheat Security App • Owner Action Guide</span>
      <span>Page 1 of 2</span>
    </div>
  </div>

  <!-- ==================== PAGE 2 ==================== -->
  <div class="page-container">
    <div>

      <!-- PART 3 -->
      <div class="section-title" style="margin-top: 2px;">Part 3: Generate & Label the Maps API Keys (2 Minutes)</div>
      <div class="step-card">
        <div class="step-card-header">
          <h3 class="step-card-title">Step 3: Create Separate API Keys for Android and Apple (iOS)</h3>
          <span class="time-tag">CRITICAL STEP</span>
        </div>
        <p style="margin: 0 0 4px 0; color: #475569; font-size: 8pt;">
          <strong>Important Requirement:</strong> To prevent security conflicts and ensure both mobile platforms operate independently, please generate <strong>two separate API keys</strong> and label them distinctly as described below.
        </p>

        <div class="access-box">
          <div class="access-row">
            <span class="access-tag primary">Option A • Direct Link</span>
            <span class="access-desc">Open Credentials page directly: <span class="url-badge">https://console.cloud.google.com/apis/credentials?project=trouble-cheat-security-app</span></span>
          </div>
          <div class="access-row">
            <span class="access-tag secondary">Option B • Via Firebase</span>
            <span class="access-desc">From Google Cloud (navigated via Firebase Settings as described in Step 2) &rarr; Click <strong>☰ Menu</strong> &rarr; <strong>APIs & Services</strong> &rarr; <strong>Credentials</strong>.</span>
          </div>
        </div>

        <div style="background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 5px; padding: 7px 9px; margin-top: 5px;">
          <p style="margin: 0 0 2px 0; font-weight: 700; color: #0f172a; font-size: 8.2pt;">A. Create Key #1 (For Google / Android):</p>
          <ol class="action-list">
            <li>Click <strong>+ CREATE CREDENTIALS</strong> at top of page &rarr; Select <strong>API key</strong>.</li>
            <li>In popup (<em>"API key created"</em>), click <strong>Edit API key</strong> (or click the key name in the credentials list).</li>
            <li>In the <strong>Name</strong> field, enter exactly: <code>Android Maps API Key</code></li>
            <li>Copy the generated key string (starts with <code>AIzaSy...</code>) and click <strong>SAVE</strong>.</li>
          </ol>

          <p style="margin: 6px 0 2px 0; font-weight: 700; color: #0f172a; font-size: 8.2pt;">B. Create Key #2 (For Apple / iOS):</p>
          <ol class="action-list">
            <li>Click <strong>+ CREATE CREDENTIALS</strong> again &rarr; Select <strong>API key</strong>.</li>
            <li>Click <strong>Edit API key</strong>.</li>
            <li>In the <strong>Name</strong> field, enter exactly: <code>Apple iOS Maps API Key</code></li>
            <li>Copy the generated key string (starts with <code>AIzaSy...</code>) and click <strong>SAVE</strong>.</li>
          </ol>
        </div>

        <table class="highlight-table">
          <thead>
            <tr>
              <th style="width: 28%;">Key Label (Name)</th>
              <th style="width: 25%;">Target Platform</th>
              <th>Usage in App</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td><strong>Android Maps API Key</strong></td>
              <td>Google Android App</td>
              <td>Used in AndroidManifest for Google Play builds & live radar.</td>
            </tr>
            <tr>
              <td><strong>Apple iOS Maps API Key</strong></td>
              <td>Apple iOS App</td>
              <td>Used in iOS AppDelegate for App Store builds & Apple device tracking.</td>
            </tr>
          </tbody>
        </table>
      </div>

      <!-- PART 4: DELIVERABLES -->
      <div class="section-title" style="margin-top: 9px;">Deliverables to Share with the Development Team</div>
      <p style="margin: 0 0 4px 0; font-size: 8.1pt; color: #334155;">
        Once the steps above are completed, please copy and reply to our team with the following details:
      </p>

      <div class="deliverables-container">
        <div class="deliverable-item">
          <span class="checkbox-icon">&#9633;</span>
          <div>
            <strong>1. Cloud Functions Activation:</strong> Confirmed ("Get Started" completed in Firebase).
          </div>
        </div>
        <div class="deliverable-item">
          <span class="checkbox-icon">&#9633;</span>
          <div>
            <strong>2. Android Maps API Key:</strong> <code>AIzaSy_________________________________</code>
          </div>
        </div>
        <div class="deliverable-item">
          <span class="checkbox-icon">&#9633;</span>
          <div>
            <strong>3. Apple iOS Maps API Key:</strong> <code>AIzaSy_________________________________</code>
          </div>
        </div>
      </div>

      <div style="margin-top: 8px; padding: 6px 9px; background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 5px; font-size: 8pt; color: #475569;">
        <strong>Next Steps:</strong> As soon as these two keys are delivered, our team will inject them into the mobile app builds, activate real-time radar mapping, and deploy the serverless safety workers. Thank you for your support!
      </div>

    </div>

    <div class="doc-footer">
      <span>Trouble-Cheat Security App • Owner Action Guide</span>
      <span>Page 2 of 2</span>
    </div>
  </div>

</body>
</html>
"""

with open(output_html, "w", encoding="utf-8") as f:
    f.write(html_content)

print(f"Updated HTML written to: {output_html}")

# Generate PDF using playwright
cmd = [
    "/Users/muhammadshaheertariq/development/work/.venv/bin/python", "-c",
    f'''
import asyncio
from playwright.async_api import async_playwright

async def generate():
    async with async_playwright() as p:
        browser = await p.chromium.launch()
        page = await browser.new_page()
        await page.goto("file://{output_html}", wait_until="networkidle")
        await page.pdf(
            path="{output_pdf}",
            format="Letter",
            print_background=True,
            margin={{"top": "0mm", "bottom": "0mm", "left": "0mm", "right": "0mm"}}
        )
        await browser.close()

asyncio.run(generate())
'''
]

subprocess.run(cmd, check=True)

reader = pypdf.PdfReader(output_pdf)
page_count = len(reader.pages)
print(f"Generated PDF at: {output_pdf}")
print(f"Page count: {page_count}")

# Copy to artifact path
with open(output_pdf, "rb") as src, open(artifact_pdf, "wb") as dst:
    dst.write(src.read())

print(f"Copied to artifact path: {artifact_pdf}")
