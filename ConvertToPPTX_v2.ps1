# PowerShell script to convert EduConnect HTML to PowerPoint presentation
# Uses COM automation with proper error handling

# Create PowerPoint application object
$ppt = New-Object -ComObject PowerPoint.Application
$ppt.Visible = 1

# Create new presentation
$presentation = $ppt.Presentations.Add()

# Define slide content based on HTML structure
$slides = @(
    @{
        Title = "EduConnect"
        Subtitle = "Professional Hall Ticket Generator"
        Content = "Streamlining Academic Administration with Modern Technology"
        IsTitle = $true
    },
    @{
        Title = "The Challenge"
        Content = @(
            "Traditional Hall Ticket Generation:",
            "",
            "• Manual, time-consuming process",
            "• Prone to human errors", 
            "• Inconsistent formatting",
            "• Limited customization options",
            "• Poor scalability"
        )
        IsTitle = $false
    },
    @{
        Title = "Our Solution: EduConnect"
        Content = @(
            "A comprehensive, web-based hall ticket generation system designed for modern educational institutions",
            "",
            "Key Features:",
            "• Lightning Fast - Generate hundreds of hall tickets in seconds",
            "• Fully Customizable - Match your institution's branding", 
            "• Secure & Reliable - Built with security and data integrity in mind"
        )
        IsTitle = $false
    },
    @{
        Title = "Key Features"
        Content = @(
            "Smart Import System:",
            "• Excel/CSV file import",
            "• Dynamic subject handling (5, 7, or more)",
            "• Automatic data validation",
            "",
            "Advanced Customization:",
            "• Multiple design templates",
            "• Logo upload support", 
            "• Color scheme customization",
            "",
            "PDF Generation:",
            "• High-quality VTU-style PDFs",
            "• Batch processing capability",
            "• Student and office copies"
        )
        IsTitle = $false
    },
    @{
        Title = "How It Works"
        Content = @(
            "Process Steps:",
            "",
            "1. Select Branch & Year - Choose from 15+ engineering branches",
            "2. Import Data - Upload Excel/CSV with student information", 
            "3. Customize Design - Apply templates and branding",
            "4. Generate & Download - Create professional PDFs instantly",
            "",
            "Time Efficiency:",
            "What traditionally takes hours now takes minutes!"
        )
        IsTitle = $false
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
            "",
            "Key Libraries:",
            "• SheetJS for Excel processing",
            "• jsPDF for PDF generation"
        )
        IsTitle = $false
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
            "",
            "For Institutions:",
            "• Cost-effective solution",
            "• Scalable architecture", 
            "• Brand consistency"
        )
        IsTitle = $false
    },
    @{
        Title = "What Makes EduConnect Special?"
        Content = @(
            "Dynamic Subject Handling:",
            "Unlike traditional systems, handles 7, 8, or any number of subjects with intelligent scaling.",
            "",
            "Mobile-First Design:",
            "Works perfectly on desktop, tablet, and mobile devices.",
            "",
            "VTU-Compliant Format:",
            "Meets VTU standards with proper formatting and layout.",
            "",
            "Zero Installation:", 
            "Runs entirely in web browser - no software installation required!"
        )
        IsTitle = $false
    },
    @{
        Title = "Future Enhancements"
        Content = @(
            "Cloud Integration:",
            "• Cloud storage integration",
            "• Real-time collaboration",
            "• Automatic backups",
            "",
            "Analytics Dashboard:",
            "• Generation statistics",
            "• Usage analytics",
            "• Performance metrics", 
            "",
            "Mobile App:",
            "• Native mobile application",
            "• Offline capability",
            "• Push notifications"
        )
        IsTitle = $false
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
        IsTitle = $true
    }
)

# Create slides
for ($i = 0; $i -lt $slides.Count; $i++) {
    $slideData = $slides[$i]
    
    # Add slide with appropriate layout
    if ($slideData.IsTitle) {
        $slide = $presentation.Slides.Add($i + 1, 1)  # Title layout
    } else {
        $slide = $presentation.Slides.Add($i + 1, 2)  # Title and Content layout
    }
    
    # Set title
    $slide.Shapes.Title.TextFrame.TextRange.Text = $slideData.Title
    
    # Set content
    if ($slideData.IsTitle) {
        # For title slides, use the second shape for subtitle/content
        $contentText = ""
        if ($slideData.Subtitle) {
            $contentText = $slideData.Subtitle + "`n`n"
        }
        if ($slideData.Content -is [array]) {
            $contentText += ($slideData.Content -join "`n")
        } elseif ($slideData.Content) {
            $contentText += $slideData.Content
        }
        
        if ($slide.Shapes.Count -ge 2) {
            $slide.Shapes[2].TextFrame.TextRange.Text = $contentText
        }
    } else {
        # For content slides
        if ($slideData.Content -is [array]) {
            $contentText = $slideData.Content -join "`n"
        } else {
            $contentText = $slideData.Content
        }
        
        if ($slide.Shapes.Count -ge 2) {
            $slide.Shapes[2].TextFrame.TextRange.Text = $contentText
        }
    }
}

# Save the presentation with timestamp to avoid conflicts
$timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
$outputPath = Join-Path (Get-Location) "EduConnect_Presentation_$timestamp.pptx"
$presentation.SaveAs($outputPath)

Write-Host "PowerPoint presentation created successfully at: $outputPath"

# Optional: Apply a design template
try {
    # Try to apply Office theme
    $themePath = "C:\Program Files\Microsoft Office\Root\Document Themes 16\Office Theme.thmx"
    if (Test-Path $themePath) {
        $presentation.ApplyTemplate($themePath)
        Write-Host "Applied Office theme successfully"
    }
} catch {
    Write-Host "Could not apply template, using default theme"
}

Write-Host "Conversion completed successfully!"
Write-Host "You can now open: $outputPath"

# Keep PowerPoint visible for user to review
# Uncomment the following lines to close PowerPoint automatically
# $presentation.Close()
# $ppt.Quit()
