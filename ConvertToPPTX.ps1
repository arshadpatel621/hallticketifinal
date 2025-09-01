# PowerShell script to convert EduConnect HTML to PowerPoint presentation
# Uses COM automation to create PPTX file

# Read the HTML file content
$htmlContent = Get-Content "EduConnect_PowerPoint_Import.html" -Raw

# Create PowerPoint application object
$ppt = New-Object -ComObject PowerPoint.Application
$ppt.Visible = 1  # Use 1 instead of $true for MsoTriState

# Create new presentation
$presentation = $ppt.Presentations.Add()

# Add an initial slide with title layout
$titleSlide = $presentation.Slides.Add(1, 1)  # ppLayoutTitle

# Define slide content based on HTML structure
$slides = @(
    @{
        Title = "EduConnect"
        Subtitle = "Professional Hall Ticket Generator"
        Content = "Streamlining Academic Administration with Modern Technology"
        Layout = "Title"
    },
    @{
        Title = "The Challenge"
        Subtitle = "Traditional Hall Ticket Generation:"
        Content = @(
            "Manual, time-consuming process",
            "Prone to human errors", 
            "Inconsistent formatting",
            "Limited customization options",
            "Poor scalability"
        )
        Layout = "Bullet"
    },
    @{
        Title = "Our Solution: EduConnect"
        Subtitle = "A comprehensive, web-based hall ticket generation system designed for modern educational institutions"
        Content = @(
            "Lightning Fast - Generate hundreds of hall tickets in seconds",
            "Fully Customizable - Match your institution's branding and requirements", 
            "Secure & Reliable - Built with security and data integrity in mind"
        )
        Layout = "Bullet"
    },
    @{
        Title = "Key Features"
        Content = @(
            "Smart Import System:",
            "• Excel/CSV file import",
            "• Dynamic subject handling (5, 7, or more)",
            "• Automatic data validation",
            "• Flexible column mapping",
            "",
            "Advanced Customization:",
            "• Multiple design templates",
            "• Logo upload support", 
            "• Color scheme customization",
            "• Font and layout options",
            "",
            "PDF Generation:",
            "• High-quality VTU-style PDFs",
            "• Batch processing capability",
            "• Student and office copies",
            "• Optimized layouts for printing"
        )
        Layout = "Bullet"
    },
    @{
        Title = "How It Works"
        Content = @(
            "Process Steps:",
            "1. Select Branch & Year - Choose from 15+ engineering branches",
            "2. Import Data - Upload Excel/CSV with student information", 
            "3. Customize Design - Apply templates and branding",
            "4. Generate & Download - Create professional PDFs instantly",
            "",
            "Time Efficiency:",
            "What traditionally takes hours now takes minutes. Generate hall tickets for an entire batch of 200+ students in under 2 minutes!"
        )
        Layout = "Bullet"
    },
    @{
        Title = "Technical Architecture"
        Content = @(
            "Technologies Used:",
            "• HTML5, CSS3, JavaScript",
            "• SheetJS, jsPDF",
            "",
            "Frontend Technologies:",
            "• Responsive design with Tailwind CSS",
            "• Modern ES6+ JavaScript",
            "• Client-side PDF generation", 
            "• Real-time preview system",
            "",
            "Key Libraries:",
            "• SheetJS for Excel processing",
            "• jsPDF for PDF generation",
            "• FontAwesome for icons",
            "• Custom validation engine"
        )
        Layout = "Bullet"
    },
    @{
        Title = "Benefits & Impact"
        Content = @(
            "Statistics:",
            "• 95% Time Reduction",
            "• 99% Accuracy Rate", 
            "• 15+ Engineering Branches",
            "• 1000+ Students Capacity",
            "",
            "For Administrators:",
            "• Eliminate manual errors",
            "• Save countless hours",
            "• Professional appearance",
            "• Easy batch processing",
            "",
            "For Institutions:",
            "• Cost-effective solution",
            "• Scalable architecture", 
            "• Brand consistency",
            "• Environmental friendly"
        )
        Layout = "Bullet"
    },
    @{
        Title = "What Makes EduConnect Special?"
        Content = @(
            "Dynamic Subject Handling:",
            "Unlike traditional systems limited to 5 subjects, EduConnect dynamically handles 7, 8, or any number of subjects with intelligent font scaling and layout optimization.",
            "",
            "Mobile-First Design:",
            "Fully responsive interface that works perfectly on desktop, tablet, and mobile devices. Generate hall tickets anywhere, anytime.",
            "",
            "VTU-Compliant Format:",
            "Specifically designed to meet VTU (Visvesvaraya Technological University) standards with proper formatting, signatures, and layout requirements.",
            "",
            "Zero Installation:", 
            "Runs entirely in web browser - no software installation, no server setup, no maintenance required. Just open and use!"
        )
        Layout = "Bullet"
    },
    @{
        Title = "Future Enhancements"
        Content = @(
            "Cloud Integration:",
            "• Cloud storage integration",
            "• Real-time collaboration",
            "• Automatic backups",
            "• Multi-user access",
            "",
            "Analytics Dashboard:",
            "• Generation statistics",
            "• Usage analytics",
            "• Performance metrics", 
            "• Student data insights",
            "",
            "Mobile App:",
            "• Native mobile application",
            "• Offline capability",
            "• Push notifications",
            "• Camera integration for photos"
        )
        Layout = "Bullet"
    },
    @{
        Title = "Thank You"
        Subtitle = "Ready to Transform Your Hall Ticket Generation?"
        Content = @(
            "Get Started Today:",
            "",
            "Website: your-website-url.com",
            "Email: support@educonnect.com", 
            "Phone: +91 9876543210"
        )
        Layout = "Title"
    }
)

# Function to add slide content
function Add-SlideContent {
    param($slide, $slideData)
    
    # Set title
    if ($slideData.Title) {
        $slide.Shapes.Title.TextFrame.TextRange.Text = $slideData.Title
    }
    
    # Handle different layouts
    if ($slideData.Layout -eq "Title") {
        if ($slideData.Subtitle) {
            $slide.Shapes[2].TextFrame.TextRange.Text = $slideData.Subtitle
        }
        if ($slideData.Content -is [array]) {
            $slide.Shapes[2].TextFrame.TextRange.Text += "`n`n" + ($slideData.Content -join "`n")
        } elseif ($slideData.Content) {
            $slide.Shapes[2].TextFrame.TextRange.Text += "`n`n" + $slideData.Content
        }
    } else {
        # Content slide with bullets
        if ($slideData.Subtitle) {
            # Add subtitle as first content
            $contentText = $slideData.Subtitle + "`n`n"
        } else {
            $contentText = ""
        }
        
        if ($slideData.Content -is [array]) {
            $contentText += $slideData.Content -join "`n"
        } else {
            $contentText += $slideData.Content
        }
        
        $slide.Shapes[2].TextFrame.TextRange.Text = $contentText
    }
}

# Create slides
for ($i = 0; $i -lt $slides.Count; $i++) {
    $slideData = $slides[$i]
    
    if ($i -eq 0) {
        # Use the first slide that's automatically created
        $slide = $presentation.Slides[1]
        # Set to title slide layout
        $slide.Layout = 1  # ppLayoutTitle
    } else {
        # Add new slide
        $slide = $presentation.Slides.Add($i + 1, 2)  # ppLayoutText
    }
    
    Add-SlideContent -slide $slide -slideData $slideData
}

# Apply design theme (optional)
try {
    $presentation.ApplyTemplate("C:\Program Files\Microsoft Office\Root\Document Themes 16\Office Theme.thmx")
} catch {
    Write-Host "Could not apply template, using default theme"
}

# Save the presentation
$outputPath = Join-Path (Get-Location) "EduConnect_Presentation.pptx"
$presentation.SaveAs($outputPath)

Write-Host "PowerPoint presentation created successfully: $outputPath"

# Close PowerPoint (optional - comment out if you want to keep it open)
# $presentation.Close()
# $ppt.Quit()

# Release COM objects
[System.Runtime.InteropServices.Marshal]::ReleaseComObject($presentation) | Out-Null
[System.Runtime.InteropServices.Marshal]::ReleaseComObject($ppt) | Out-Null
[System.GC]::Collect()
[System.GC]::WaitForPendingFinalizers()

Write-Host "Conversion completed successfully!"
