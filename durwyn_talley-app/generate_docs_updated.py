import docx
from docx import Document
from docx.shared import Inches, Pt, RGBColor
from docx.enum.text import WD_ALIGN_PARAGRAPH
from docx.enum.table import WD_TABLE_ALIGNMENT
from docx.oxml import parse_xml
from docx.oxml.ns import nsdecls

def set_cell_background(cell, fill_hex):
    shading_elm = parse_xml(f'<w:shd {nsdecls("w")} w:fill="{fill_hex}"/>')
    cell._tc.get_or_add_tcPr().append(shading_elm)

def set_cell_margins(cell, top=120, bottom=120, left=140, right=140):
    tcPr = cell._tc.get_or_add_tcPr()
    tcMar = parse_xml(f'<w:tcMar {nsdecls("w")}><w:top w:w="{top}" w:type="dxa"/><w:bottom w:w="{bottom}" w:type="dxa"/><w:left w:w="{left}" w:type="dxa"/><w:right w:w="{right}" w:type="dxa"/></w:tcMar>')
    tcPr.append(tcMar)

def create_docx():
    doc = Document()
    
    # Page Margins (0.75 in)
    for section in doc.sections:
        section.top_margin = Inches(0.75)
        section.bottom_margin = Inches(0.75)
        section.left_margin = Inches(0.75)
        section.right_margin = Inches(0.75)
        
    # Styles
    normal_style = doc.styles['Normal']
    normal_style.font.name = 'Arial'
    normal_style.font.size = Pt(10)
    normal_style.font.color.rgb = RGBColor(34, 34, 34)
    
    # Header
    title_p = doc.add_paragraph()
    title_p.alignment = WD_ALIGN_PARAGRAPH.CENTER
    title_run = title_p.add_run("Durwyn Talley\n")
    title_run.font.size = Pt(20)
    title_run.font.bold = True
    title_run.font.color.rgb = RGBColor(17, 17, 17)
    
    sub_run = title_p.add_run("Project Requirements — Trouble Cheat")
    sub_run.font.size = Pt(14)
    sub_run.font.bold = True
    sub_run.font.color.rgb = RGBColor(50, 50, 50)
    
    doc.add_paragraph()
    
    # Executive Note
    h1 = doc.add_paragraph()
    h1_run = h1.add_run("Executive Note and Delivery Prioritization")
    h1_run.font.size = Pt(11)
    h1_run.font.bold = True
    h1_run.font.color.rgb = RGBColor(17, 17, 17)
    
    p_desc = doc.add_paragraph(
        "To ensure rapid engineering velocity and achieve target milestone releases on schedule without deployment bottlenecks, "
        "this document outlines all required credentials, platform access, branding assets, and legal documentation. "
        "To facilitate a seamless workflow, deliverables are organized into three prioritized tiers:"
    )
    p_desc.paragraph_format.line_spacing = 1.15
    
    bullets = [
        ("Tier 1 (Immediate Priority): ", "Foundational cloud accounts, developer consoles, hosting environments, and core branding assets. These items are critical blockers required upfront to configure secure server environments, continuous integration pipelines, and mobile test tracks."),
        ("Tier 2 (Priority Legal Asset): ", "Terms of Service (ToS / EULA), required promptly during the user onboarding and registration phase."),
        ("Tier 3 (Pre-Launch Legal Suite): ", "Supporting compliance disclosures and policies, which can be delivered progressively ahead of official store submission.")
    ]
    for b_title, b_text in bullets:
        bp = doc.add_paragraph(style='List Bullet')
        r1 = bp.add_run(b_title)
        r1.bold = True
        r2 = bp.add_run(b_text)
        bp.paragraph_format.line_spacing = 1.15
        
    doc.add_paragraph()
    
    # Section 1
    s1 = doc.add_paragraph()
    s1_run = s1.add_run("SECTION 1: TIER 1: IMMEDIATE PRIORITY (TECHNICAL AND BRANDING)")
    s1_run.font.size = Pt(11)
    s1_run.font.bold = True
    s1_run.font.color.rgb = RGBColor(17, 17, 17)
    
    stat_p = doc.add_paragraph()
    stat_r1 = stat_p.add_run("Status: Immediate Blockers. ")
    stat_r1.bold = True
    stat_r1.italic = True
    stat_r2 = stat_p.add_run(
        "Development environment setup cannot proceed safely without these items. Providing these upfront guarantees "
        "that our engineering team can configure cloud services, establish automated testing, and prepare App Store and Google Play submissions without interruption."
    )
    stat_r2.italic = True
    
    # Table 1: Technical Accounts
    t1_data = [
        ("1", "Apple Developer Account", 
         "• Organization Account: Grant Admin Access to:\niamshaheertariq@gmail.com\n\n• Individual Account: Provide Apple ID and Password (note: one-time SMS/device verification OTP will be required during our initial login session).", 
         "Required for generating distribution certificates, provisioning profiles, signing iOS builds, setting up TestFlight beta distribution for client reviews, configuring Apple Push Notification service (APNs), and publishing on the Apple App Store."),
        ("2", "Google Play Console", 
         "• Grant Admin or Owner Access to:\nmichaelsmith02444@gmail.com", 
         "Required for configuring the store listing, managing internal and closed testing tracks, signing Android .aab bundles, configuring Google Play Billing, and deploying the app on the Google Play Store."),
        ("3", "Firebase (Blaze Plan)", 
         "• Grant Owner Access to:\nmichaelsmith02444@gmail.com\n(Project must be upgraded to the Blaze Plan — Pay as you go)", 
         "Required to configure Cloud Firestore (real-time GPS breadcrumb streaming), Cloud Storage (audio and video emergency evidence), Firebase Authentication (phone SMS OTP, Apple/Google sign-in), Cloud Functions, and Firebase Cloud Messaging (FCM). Owner access is mandatory to access the linked Google Cloud Console to enable Google Maps Platform APIs, grant Cloud Function IAM permissions, and manage project billing."),
        ("4", "Hostinger (VPS Hosting & Custom Domain)", 
         "• Grant Direct Account / Admin Access to:\nmichaelsmith02444@gmail.com\n(Direct Hostinger account access with active VPS and Domain)", 
         "Required for our team to directly configure, deploy, run, and maintain the custom persistent backend infrastructure: the 24/7 server-side Safety Timer worker (ensuring emergency alerts dispatch even if the user's phone powers off or loses connectivity), the Web Admin Portal, the live public emergency tracking viewer (track.troublecheat.com), Nginx reverse proxy, automated SSL/TLS certificates (HTTPS), and DNS records."),
        ("5", "SMS / Messaging Service", 
         "• Grant Account Access to:\nmichaelsmith02444@gmail.com\n(Client's choice: Twilio or Telnyx)", 
         "Required to send automated emergency SMS alerts with live tracking links to designated contacts, trigger emergency voice call dispatch during active SOS or expired Safety Timers, and handle phone verification OTPs. Must be funded and enabled with a verified 10DLC or Toll-Free number for domestic and international SMS delivery across all target countries."),
        ("6", "Google Cloud Console (Google Maps Platform)", 
         "• Grant Editor / Owner Access to:\nmichaelsmith02444@gmail.com\n(Can be linked directly through the Firebase GCP Project)", 
         "Required to enable and generate API keys for the Google Maps SDK (iOS & Android) for in-app interactive map rendering, as well as the Geocoding and Reverse Geocoding APIs to convert live GPS latitude/longitude coordinates into human-readable street addresses for emergency alerts and history logs.")
    ]
    
    headers1 = ["#", "Platform / Service", "Required Access Level", "Purpose & Technical Justification"]
    col_widths1 = [Inches(0.4), Inches(1.8), Inches(2.2), Inches(2.6)]
    
    table1 = doc.add_table(rows=1, cols=4)
    table1.alignment = WD_TABLE_ALIGNMENT.CENTER
    
    hdr_cells = table1.rows[0].cells
    for i, title in enumerate(headers1):
        hdr_cells[i].text = title
        hdr_cells[i].paragraphs[0].runs[0].font.bold = True
        hdr_cells[i].paragraphs[0].runs[0].font.size = Pt(9.5)
        hdr_cells[i].paragraphs[0].runs[0].font.color.rgb = RGBColor(255, 255, 255)
        set_cell_background(hdr_cells[i], "111111")
        set_cell_margins(hdr_cells[i], top=120, bottom=120, left=140, right=140)
        hdr_cells[i].width = col_widths1[i]
        
    for row_idx, data in enumerate(t1_data):
        row_cells = table1.add_row().cells
        bg_color = "FAFAFA" if row_idx % 2 == 1 else "FFFFFF"
        for i, val in enumerate(data):
            row_cells[i].text = val
            p = row_cells[i].paragraphs[0]
            p.paragraph_format.line_spacing = 1.1
            for r in p.runs:
                r.font.size = Pt(9)
                r.font.color.rgb = RGBColor(34, 34, 34)
            set_cell_background(row_cells[i], bg_color)
            set_cell_margins(row_cells[i], top=120, bottom=120, left=140, right=140)
            row_cells[i].width = col_widths1[i]
            
    doc.add_paragraph()
    
    # Branding Subsection
    b_head = doc.add_paragraph()
    b_head_run = b_head.add_run("App Branding and Store Visual Assets (Immediate Priority)")
    b_head_run.font.size = Pt(11)
    b_head_run.font.bold = True
    b_head_run.font.color.rgb = RGBColor(17, 17, 17)
    
    t2_data = [
        ("7", "Official App Name", "Final approved name\n(Display title: \"Trouble Cheat\")", "Required for official Apple App Store and Google Play listings, phone home-screen display labels, push notification headers, and legal disclaimers."),
        ("8", "App Logo / Launcher Icon", "Vector SVG / AI or 1024 x 1024 px Transparent PNG", "Required to compile launcher icon assets across all iOS and Android resolutions, in-app splash screens, notification status-bar icons, PDF exports, and web portal favicon."),
        ("9", "Google Play Feature Graphic", "1024 x 500 px (PNG or JPEG, 24-bit, no alpha/transparency)", "Mandatory requirement for Google Play Store publication. Serves as the primary promotional banner displayed at the top of the app store listing page on Android devices."),
        ("10", "Web Admin & Portal Branding Assets", "Horizontal logo variant and browser favicon", "Required for deployment across the Web Admin Portal, email notification templates, and the public emergency tracking portal.")
    ]
    
    headers2 = ["#", "Asset Name", "Required Specification", "Purpose & Technical Justification"]
    col_widths2 = [Inches(0.4), Inches(1.8), Inches(2.2), Inches(2.6)]
    
    table2 = doc.add_table(rows=1, cols=4)
    table2.alignment = WD_TABLE_ALIGNMENT.CENTER
    
    hdr2_cells = table2.rows[0].cells
    for i, title in enumerate(headers2):
        hdr2_cells[i].text = title
        hdr2_cells[i].paragraphs[0].runs[0].font.bold = True
        hdr2_cells[i].paragraphs[0].runs[0].font.size = Pt(9.5)
        hdr2_cells[i].paragraphs[0].runs[0].font.color.rgb = RGBColor(255, 255, 255)
        set_cell_background(hdr2_cells[i], "111111")
        set_cell_margins(hdr2_cells[i], top=120, bottom=120, left=140, right=140)
        hdr2_cells[i].width = col_widths2[i]
        
    for row_idx, data in enumerate(t2_data):
        row_cells = table2.add_row().cells
        bg_color = "FAFAFA" if row_idx % 2 == 1 else "FFFFFF"
        for i, val in enumerate(data):
            row_cells[i].text = val
            p = row_cells[i].paragraphs[0]
            p.paragraph_format.line_spacing = 1.1
            for r in p.runs:
                r.font.size = Pt(9)
                r.font.color.rgb = RGBColor(34, 34, 34)
            set_cell_background(row_cells[i], bg_color)
            set_cell_margins(row_cells[i], top=120, bottom=120, left=140, right=140)
            row_cells[i].width = col_widths2[i]
            
    doc.add_page_break()
    
    # Section 2
    s2 = doc.add_paragraph()
    s2_run = s2.add_run("SECTION 2: LEGAL AND COMPLIANCE DOCUMENTATION (TIERS 2 AND 3)")
    s2_run.font.size = Pt(11)
    s2_run.font.bold = True
    s2_run.font.color.rgb = RGBColor(17, 17, 17)
    
    leg_p = doc.add_paragraph(
        "Because this is a personal safety and emergency response tracking platform involving background location logging, "
        "emergency audio/video capture, and automated contact alerting, all legal text must be authored or ratified by the client "
        "(attorney/legal entity). Terms of Service is needed promptly for user onboarding; supporting compliance disclosures can be finalized prior to store submission."
    )
    leg_p.paragraph_format.line_spacing = 1.15
    
    t3_data = [
        ("L-1", "Terms of Service (ToS / EULA)", "Tier 2:\nNeeded Promptly\n(During Onboarding Build)", "The primary user contract that subscribers must review and explicitly accept upon account creation and subscription checkout. Mandated by Apple for all auto-renewing subscriptions."),
        ("L-2", "Privacy Policy", "Tier 3:\nPre-Launch\n(Mandatory for Store Review)", "Mandatory for Apple App Store and Google Play approval. Must formally disclose data collection practices: continuous background GPS tracking frequency, audio/video evidence capture, data retention timelines, and third-party data handling (Firebase, Twilio, Hostinger)."),
        ("L-3", "Emergency Dispatch & 911 Disclaimer", "Tier 3:\nPre-Launch\n(Before Store Submission)", "Critical compliance disclaimer explicitly clarifying that the app is a supplementary personal safety tool and not an authorized municipal 911 dispatch service. Mandatory to prevent Apple Guideline 1.4 (Physical Harm / Emergency Services) rejection."),
        ("L-4", "Continuous Location Tracking Consent", "Tier 3:\nPre-Launch\n(Before Production Build)", "In-app modal agreement explaining continuous background location logging during active Safety Timer, SOS alerts, and Safety Monitoring sessions, detailing how coordinates are shared with emergency contacts."),
        ("L-5", "Emergency Audio & Video Evidence Recording Consent", "Tier 3:\nPre-Launch\n(Before Verification Testing)", "Explicit consent disclosure presented to the user prior to enabling Silent Emergency and SOS recording features, explaining how microphone and camera feeds are captured and stored in cloud infrastructure."),
        ("L-6", "Data Retention and Cloud Storage Purge Policy", "Tier 3:\nPre-Launch\n(Before Production Deployment)", "Defines exact legal timelines (such as Free Tier: 3 days, Standard Tier: 14 days, Premium Tier: 30 days) before emergency recordings, audio files, and GPS routes are permanently purged from cloud storage.")
    ]
    
    headers3 = ["#", "Document / Disclosure", "Delivery Timeline", "Purpose & In-App Application"]
    col_widths3 = [Inches(0.5), Inches(2.0), Inches(1.8), Inches(2.7)]
    
    table3 = doc.add_table(rows=1, cols=4)
    table3.alignment = WD_TABLE_ALIGNMENT.CENTER
    
    hdr3_cells = table3.rows[0].cells
    for i, title in enumerate(headers3):
        hdr3_cells[i].text = title
        hdr3_cells[i].paragraphs[0].runs[0].font.bold = True
        hdr3_cells[i].paragraphs[0].runs[0].font.size = Pt(9.5)
        hdr3_cells[i].paragraphs[0].runs[0].font.color.rgb = RGBColor(255, 255, 255)
        set_cell_background(hdr3_cells[i], "111111")
        set_cell_margins(hdr3_cells[i], top=120, bottom=120, left=140, right=140)
        hdr3_cells[i].width = col_widths3[i]
        
    for row_idx, data in enumerate(t3_data):
        row_cells = table3.add_row().cells
        bg_color = "FAFAFA" if row_idx % 2 == 1 else "FFFFFF"
        for i, val in enumerate(data):
            row_cells[i].text = val
            p = row_cells[i].paragraphs[0]
            p.paragraph_format.line_spacing = 1.1
            for r in p.runs:
                r.font.size = Pt(9)
                r.font.color.rgb = RGBColor(34, 34, 34)
            set_cell_background(row_cells[i], bg_color)
            set_cell_margins(row_cells[i], top=120, bottom=120, left=140, right=140)
            row_cells[i].width = col_widths3[i]
            
    doc_path = "/Users/muhammadshaheertariq/development/durwyn_talley-main/Durwyn_Talley_Project_Requirements.docx"
    doc.save(doc_path)
    print(f"Successfully generated updated DOCX at: {doc_path}")

create_docx()
