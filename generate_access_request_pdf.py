import os
import base64
import subprocess
import pypdf

# Paths
root_dir = os.path.dirname(os.path.abspath(__file__))
img1_path = "/Users/muhammadshaheertariq/.gemini/antigravity/brain/ca26fcdc-d72c-431d-b583-4fbb92364283/gcp_missing_permission_maps.jpg"
img2_path = "/Users/muhammadshaheertariq/.gemini/antigravity/brain/ca26fcdc-d72c-431d-b583-4fbb92364283/firebase_functions_owner_required.jpg"
output_html = os.path.join(root_dir, "Firebase_Owner_Access_Request.html")
output_pdf = os.path.join(root_dir, "Firebase_Owner_Access_Request.pdf")
artifact_pdf = "/Users/muhammadshaheertariq/.gemini/antigravity/brain/ca26fcdc-d72c-431d-b583-4fbb92364283/Firebase_Owner_Access_Request.pdf"

# Encode images
with open(img1_path, "rb") as f:
    img1_b64 = base64.b64encode(f.read()).decode("utf-8")

with open(img2_path, "rb") as f:
    img2_b64 = base64.b64encode(f.read()).decode("utf-8")

html_content = f"""<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Firebase & GCP Owner Access Request - Trouble Cheat Security App</title>
<style>
  @page {{
    size: letter;
    margin: 12mm 15mm 12mm 15mm;
  }}

  * {{
    box-sizing: border-box;
  }}

  body {{
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
    color: #1e293b;
    line-height: 1.45;
    font-size: 9pt;
    margin: 0;
    padding: 0;
    background-color: #ffffff;
  }}

  .page-container {{
    min-height: 254mm;
    max-height: 254mm;
    position: relative;
    page-break-after: always;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
  }}

  .page-container:last-child {{
    page-break-after: avoid;
  }}

  /* Header */
  .header-container {{
    border-bottom: 2px solid #0f172a;
    padding-bottom: 10px;
    margin-bottom: 12px;
  }}

  .app-badge {{
    display: inline-block;
    font-size: 7.5pt;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 1.2px;
    color: #b91c1c;
    background-color: #fee2e2;
    padding: 3px 8px;
    border-radius: 4px;
    margin-bottom: 6px;
    border: 1px solid #fecaca;
  }}

  .doc-title {{
    font-size: 16pt;
    font-weight: 800;
    color: #0f172a;
    margin: 0 0 4px 0;
    letter-spacing: -0.3px;
  }}

  .doc-subtitle {{
    font-size: 9.5pt;
    color: #64748b;
    margin: 0;
  }}

  /* Meta table */
  .meta-grid {{
    display: grid;
    grid-template-columns: 1.15fr 1.55fr 1.65fr 1.1fr;
    gap: 8px;
    background-color: #f8fafc;
    border: 1px solid #e2e8f0;
    border-radius: 6px;
    padding: 8px 12px;
    margin-bottom: 14px;
  }}

  .meta-item {{
    font-size: 8pt;
  }}

  .meta-label {{
    color: #64748b;
    font-weight: 600;
    text-transform: uppercase;
    font-size: 7pt;
    margin-bottom: 2px;
  }}

  .meta-value {{
    color: #0f172a;
    font-weight: 700;
  }}

  .meta-value code {{
    background: #e2e8f0;
    padding: 2px 4px;
    border-radius: 3px;
    font-size: 7.5pt;
    font-family: ui-monospace, Menlo, Monaco, monospace;
    white-space: nowrap;
  }}

  /* Section styles */
  .section-title {{
    font-size: 11pt;
    font-weight: 700;
    color: #0f172a;
    margin: 0 0 6px 0;
    display: flex;
    align-items: center;
    gap: 6px;
  }}

  .section-title::before {{
    content: "";
    display: inline-block;
    width: 4px;
    height: 13px;
    background: #2563eb;
    border-radius: 2px;
  }}

  p {{
    margin: 0 0 8px 0;
    color: #334155;
  }}

  /* Highlight box */
  .alert-box {{
    background-color: #fffbeb;
    border-left: 3.5px solid #f59e0b;
    padding: 8px 12px;
    border-radius: 0 5px 5px 0;
    margin-bottom: 12px;
    font-size: 8.5pt;
  }}

  .alert-box strong {{
    color: #92400e;
  }}

  /* Blocker Card */
  .blocker-card {{
    background: #ffffff;
    border: 1px solid #cbd5e1;
    border-radius: 6px;
    padding: 10px 12px;
    margin-bottom: 12px;
    box-shadow: 0 1px 3px rgba(0,0,0,0.04);
  }}

  .blocker-header {{
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 6px;
  }}

  .blocker-tag {{
    font-size: 7pt;
    font-weight: 700;
    text-transform: uppercase;
    padding: 2px 6px;
    border-radius: 3px;
    background: #fee2e2;
    color: #991b1b;
  }}

  .blocker-title {{
    font-size: 9.5pt;
    font-weight: 700;
    color: #0f172a;
    margin: 0;
  }}

  .screenshot-container {{
    margin-top: 8px;
    border: 1px solid #e2e8f0;
    border-radius: 5px;
    overflow: hidden;
    background: #0f172a;
    text-align: center;
  }}

  .screenshot-container img {{
    width: 100%;
    max-height: 108mm;
    object-fit: contain;
    display: block;
    margin: 0 auto;
  }}

  .screenshot-caption {{
    font-size: 7.5pt;
    color: #64748b;
    padding: 4px 8px;
    background: #f8fafc;
    border-top: 1px solid #e2e8f0;
    text-align: left;
    font-style: italic;
  }}

  /* Action Steps */
  .steps-container {{
    background: #f0fdf4;
    border: 1.5px solid #86efac;
    border-radius: 6px;
    padding: 12px 14px;
    margin: 12px 0;
  }}

  .step-row {{
    display: flex;
    align-items: flex-start;
    gap: 10px;
    margin-bottom: 8px;
  }}

  .step-row:last-child {{
    margin-bottom: 0;
  }}

  .step-num {{
    background: #16a34a;
    color: white;
    font-size: 8pt;
    font-weight: 700;
    width: 20px;
    height: 20px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
    margin-top: 1px;
  }}

  .step-text {{
    font-size: 8.5pt;
    color: #14532d;
    line-height: 1.4;
  }}

  .step-text strong {{
    color: #0f172a;
  }}

  /* Footer */
  .doc-footer {{
    border-top: 1px solid #e2e8f0;
    padding-top: 6px;
    font-size: 7.5pt;
    color: #94a3b8;
    display: flex;
    justify-content: space-between;
    align-items: center;
  }}
</style>
</head>
<body>

  <!-- ==================== PAGE 1 ==================== -->
  <div class="page-container">
    <div>
      <div class="header-container">
        <div class="app-badge">Action Required • Access Privileges</div>
        <h1 class="doc-title">Firebase & Google Cloud Platform (GCP) Owner Access Request</h1>
        <p class="doc-subtitle">Resolution of Permissions Blockers for Maps Integration and Cloud Functions Automation</p>
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
          <div class="meta-label">Account to Upgrade</div>
          <div class="meta-value"><code>michaelsmith02444@gmail.com</code></div>
        </div>
        <div class="meta-item">
          <div class="meta-label">Requested Role</div>
          <div class="meta-value" style="color: #16a34a;">Project Owner</div>
        </div>
      </div>

      <div class="section-title">Executive Summary</div>
      <p>
        The core cloud infrastructure for the <strong>Trouble-Cheat Security App</strong> has been successfully connected: Cloud Firestore database and Cloud Storage rules are deployed live, and the FastAPI backend is communicating directly with Google Firebase.
      </p>
      <p>
        However, active mobile application development has encountered <strong>two critical administrative blockers</strong>. Because the development team account is currently assigned standard Editor/Collaborator rights, Google Cloud Platform (GCP) and Firebase actively restrict the activation of necessary services. We kindly request upgrading <strong><code>michaelsmith02444@gmail.com</code></strong> to <strong>Owner</strong> to unblock these dependencies.
      </p>

      <div class="blocker-card" style="margin-top: 10px;">
        <div class="blocker-header">
          <h3 class="blocker-title">Blocker 1: Inability to Enable Google Maps APIs (GCP Permission Error)</h3>
          <span class="blocker-tag">Service Usage Blocked</span>
        </div>
        <p style="font-size: 8.5pt; margin-bottom: 6px;">
          <strong>Impact:</strong> The app relies on live location tracking, GPS breadcrumb trails, and emergency incident mapping. Attempting to activate the <em>Maps SDK for Android</em> and related Google Maps APIs fails with a strict permission denial: <code>serviceusage.services.enable</code>. Only a project Owner has permission to enable APIs on this billing project.
        </p>

        <div class="screenshot-container">
          <img src="data:image/jpeg;base64,{img1_b64}" alt="Google Cloud Missing Permission Error">
          <div class="screenshot-caption">
            <strong>Figure 1.1:</strong> Google Cloud Console prompt denying activation of Maps SDK due to missing <code>serviceusage.services.enable</code> permission.
          </div>
        </div>
      </div>
    </div>

    <div class="doc-footer">
      <span>Trouble-Cheat Security App • Infrastructure & Access Documentation</span>
      <span>Page 1 of 2</span>
    </div>
  </div>

  <!-- ==================== PAGE 2 ==================== -->
  <div class="page-container">
    <div>
      <div class="blocker-card" style="margin-top: 4px;">
        <div class="blocker-header">
          <h3 class="blocker-title">Blocker 2: Firebase Cloud Functions First-Time Setup Restricted</h3>
          <span class="blocker-tag">Cloud Functions Blocked</span>
        </div>
        <p style="font-size: 8.5pt; margin-bottom: 6px;">
          <strong>Impact:</strong> Cloud Functions powers the automated 24/7 Safety Timer worker, incident resolution webhooks, and push notification triggers for emergency contacts. Firebase explicitly mandates that a <strong>Project Owner</strong> must perform the initial setup before functions can be deployed.
        </p>

        <div class="screenshot-container">
          <img src="data:image/jpeg;base64,{img2_b64}" alt="Firebase Functions Owner Required Banner">
          <div class="screenshot-caption">
            <strong>Figure 2.1:</strong> Firebase Console Functions page displaying mandatory requirement: <em>"Ask a project owner to set up Functions before using it for the first time."</em>
          </div>
        </div>
      </div>

      <div class="section-title" style="margin-top: 14px;">Resolution Steps (Requires ~60 Seconds)</div>
      <p style="font-size: 8.5pt;">
        Please complete the following three quick steps in your Firebase Console to assign Owner privileges:
      </p>

      <div class="steps-container">
        <div class="step-row">
          <div class="step-num">1</div>
          <div class="step-text">
            Go to the <strong>Firebase Console</strong> &rarr; Select <strong>Trouble-Cheat Security App</strong>.<br>
            Click the <strong>Project Settings</strong> gear icon at the top-left, then select the <strong>Users and permissions</strong> tab.
          </div>
        </div>

        <div class="step-row">
          <div class="step-num">2</div>
          <div class="step-text">
            Locate <strong><code>michaelsmith02444@gmail.com</code></strong> in the members list.<br>
            Click the <strong>three dots (⋮)</strong> menu on the right-hand side and choose <strong>Edit role</strong>.
          </div>
        </div>

        <div class="step-row">
          <div class="step-num">3</div>
          <div class="step-text">
            Change the assigned role to <strong>Owner</strong> and click <strong>Save</strong>.
          </div>
        </div>
      </div>

      <div class="alert-box">
        <strong>Direct Console Link:</strong><br>
        <span style="font-size: 8pt; color: #1e293b;">
          https://console.firebase.google.com/project/trouble-cheat-security-app/settings/usersandpermissions
        </span>
      </div>

      <div class="section-title">Security & Handover Commitment</div>
      <p style="font-size: 8.5pt; color: #475569;">
        Owner privileges are strictly utilized to enable necessary Google Cloud service APIs (Maps SDK, Cloud Messaging, Service Usage), provision initial Cloud Function triggers, and verify automated production deployments. Once this phase is finalized, your team may audit access or adjust our permissions to standard maintainer roles.
      </p>
    </div>

    <div class="doc-footer">
      <span>Trouble-Cheat Security App • Infrastructure & Access Documentation</span>
      <span>Page 2 of 2</span>
    </div>
  </div>

</body>
</html>
"""

# Write HTML file
with open(output_html, "w", encoding="utf-8") as f:
    f.write(html_content)

# Generate PDF with Google Chrome
chrome_path = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
cmd = [
    chrome_path,
    "--headless",
    "--disable-gpu",
    f"--print-to-pdf={output_pdf}",
    "--no-pdf-header-footer",
    output_html
]
subprocess.run(cmd, capture_output=True, text=True)

with open(output_pdf, "rb") as fsrc:
    with open(artifact_pdf, "wb") as fdst:
        fdst.write(fsrc.read())

reader = pypdf.PdfReader(output_pdf)
print(f"Verified PDF: {output_pdf} (Pages: {len(reader.pages)})")
