import os
import base64
import subprocess
import pypdf

root_dir = os.path.dirname(os.path.abspath(__file__))
img1_path = "/Users/muhammadshaheertariq/.gemini/antigravity/brain/ca26fcdc-d72c-431d-b583-4fbb92364283/gcp_missing_permission_maps.jpg"
img2_path = "/Users/muhammadshaheertariq/.gemini/antigravity/brain/ca26fcdc-d72c-431d-b583-4fbb92364283/firebase_functions_owner_required.jpg"
output_html = os.path.join(root_dir, "Trouble_Cheat_Firebase_Owner_Access_Request.html")
output_pdf = os.path.join(root_dir, "Trouble_Cheat_Firebase_Owner_Access_Request.pdf")
artifact_pdf = "/Users/muhammadshaheertariq/.gemini/antigravity/brain/ca26fcdc-d72c-431d-b583-4fbb92364283/Trouble_Cheat_Firebase_Owner_Access_Request.pdf"

with open(img1_path, "rb") as f:
    img1_b64 = base64.b64encode(f.read()).decode("utf-8")

with open(img2_path, "rb") as f:
    img2_b64 = base64.b64encode(f.read()).decode("utf-8")

html_content = f"""<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Action Required: Firebase & Google Cloud Owner Access</title>
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
    line-height: 1.48;
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
    grid-template-columns: 1.2fr 1.6fr 1.8fr 1.1fr;
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

  /* Why we need owner callout */
  .reason-callout {{
    background: #eff6ff;
    border: 1px solid #bfdbfe;
    border-left: 4px solid #2563eb;
    border-radius: 5px;
    padding: 10px 12px;
    margin-bottom: 14px;
    font-size: 8.8pt;
    color: #1e3a8a;
    line-height: 1.5;
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
    margin: 14px 0 10px 0;
  }}

  .step-row {{
    display: flex;
    align-items: flex-start;
    gap: 10px;
    margin-bottom: 10px;
  }}

  .step-row:last-child {{
    margin-bottom: 0;
  }}

  .step-num {{
    background: #16a34a;
    color: white;
    font-size: 8.5pt;
    font-weight: 700;
    width: 22px;
    height: 22px;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    flex-shrink: 0;
    margin-top: 1px;
  }}

  .step-text {{
    font-size: 9pt;
    color: #14532d;
    line-height: 1.45;
  }}

  .step-text strong {{
    color: #0f172a;
  }}

  .direct-link-box {{
    background-color: #f8fafc;
    border: 1px solid #e2e8f0;
    border-radius: 5px;
    padding: 8px 12px;
    margin-top: 10px;
    font-size: 8pt;
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
        <div class="app-badge">Action Required • Development Access</div>
        <h1 class="doc-title">Firebase & Google Cloud Platform — Owner Access Request</h1>
        <p class="doc-subtitle">Trouble-Cheat Security App • Infrastructure & API Configuration</p>
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
          <div class="meta-label">Required Role</div>
          <div class="meta-value" style="color: #16a34a;">Project Owner</div>
        </div>
      </div>

      <div class="section-title">Why Owner Access Is Required</div>
      <div class="reason-callout">
        <strong>Notice regarding project configuration and workflow efficiency:</strong><br>
        To configure the app’s <strong>Cloud Functions, APIs, and cloud services</strong> seamlessly, our engineering team requires <strong>Owner access</strong> on Firebase and Google Cloud.
        <br><br>
        Without Owner privileges, routine configuration steps trigger permission denials that will continuously stall development and force us to schedule frequent meetings and go back-and-forth with you just to manually approve minor technical settings. You would need to be available at all times throughout the setup and configuration process to join live coordination calls whenever an API or service toggle is required.
        <br><br>
        Granting Owner access allows our team to handle all technical configurations directly and autonomously on our end—preventing delays, keeping the development moving smoothly, and saving you from unnecessary coordination calls.
      </div>

      <div class="blocker-card" style="margin-top: 8px;">
        <div class="blocker-header">
          <h3 class="blocker-title">Screen 1: Google Cloud APIs (Maps SDK & Service Usage Denied)</h3>
          <span class="blocker-tag">API Activation Blocked</span>
        </div>
        <p style="font-size: 8.5pt; margin-bottom: 6px;">
          Activating required location mapping services (such as <em>Maps SDK for Android</em> for GPS radar tracking) fails with error <code>serviceusage.services.enable</code> because standard roles cannot enable Google Cloud service APIs.
        </p>

        <div class="screenshot-container">
          <img src="data:image/jpeg;base64,{img1_b64}" alt="Google Cloud Missing Permission Error">
          <div class="screenshot-caption">
            <strong>Evidence 1:</strong> Google Cloud Console prompt blocking Maps SDK activation due to missing <code>serviceusage.services.enable</code> permission.
          </div>
        </div>
      </div>
    </div>

    <div class="doc-footer">
      <span>Trouble-Cheat Security App • Developer Access Request</span>
      <span>Page 1 of 2</span>
    </div>
  </div>

  <!-- ==================== PAGE 2 ==================== -->
  <div class="page-container">
    <div>
      <div class="blocker-card" style="margin-top: 4px;">
        <div class="blocker-header">
          <h3 class="blocker-title">Screen 2: Firebase Cloud Functions (Initial Setup Blocked)</h3>
          <span class="blocker-tag">Functions Setup Blocked</span>
        </div>
        <p style="font-size: 8.5pt; margin-bottom: 6px;">
          Firebase Cloud Functions (needed for background safety timers, emergency notifications, and webhook automation) cannot be initialized. Firebase strictly requires a <strong>Project Owner</strong> for first-time activation.
        </p>

        <div class="screenshot-container">
          <img src="data:image/jpeg;base64,{img2_b64}" alt="Firebase Functions Owner Required Banner">
          <div class="screenshot-caption">
            <strong>Evidence 2:</strong> Firebase Console Functions page stating: <em>"Ask a project owner to set up Functions before using it for the first time."</em>
          </div>
        </div>
      </div>

      <div class="section-title" style="margin-top: 14px;">How to Grant Owner Access (Takes Less Than 1 Minute)</div>
      <p style="font-size: 8.8pt;">
        Please follow these quick steps in your Firebase Console to assign the Owner role:
      </p>

      <div class="steps-container">
        <div class="step-row">
          <div class="step-num">1</div>
          <div class="step-text">
            Go to <strong>Firebase Console</strong> &rarr; Select <strong>Trouble-Cheat Security App</strong> &rarr; Click <strong>Project Settings</strong> (gear icon ⚙️) &rarr; Open the <strong>Users and permissions</strong> tab.
          </div>
        </div>

        <div class="step-row">
          <div class="step-num">2</div>
          <div class="step-text">
            Click the <strong>three dots (⋮)</strong> next to <strong><code>michaelsmith02444@gmail.com</code></strong>, change the role to <strong>Owner</strong>, and hit <strong>Save</strong>.
          </div>
        </div>
      </div>

      <div class="direct-link-box">
        <strong>Direct Console Link:</strong><br>
        <span style="font-size: 8pt; color: #2563eb;">
          https://console.firebase.google.com/project/trouble-cheat-security-app/settings/usersandpermissions
        </span>
      </div>

      <div style="margin-top: 14px; padding: 10px 12px; background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 5px;">
        <strong style="color: #0f172a; font-size: 8.5pt;">Summary:</strong>
        <p style="font-size: 8.2pt; color: #475569; margin: 4px 0 0 0;">
          Once this single change is saved, our team will have the permissions required to enable all app APIs, deploy Cloud Functions, and continue active development without any further administrative interruption.
        </p>
      </div>
    </div>

    <div class="doc-footer">
      <span>Trouble-Cheat Security App • Developer Access Request</span>
      <span>Page 2 of 2</span>
    </div>
  </div>

</body>
</html>
"""

with open(output_html, "w", encoding="utf-8") as f:
    f.write(html_content)

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
print(f"Verified PDF: {output_pdf} (Pages: {len(reader.pages)}, Size: {os.path.getsize(output_pdf)} bytes)")
