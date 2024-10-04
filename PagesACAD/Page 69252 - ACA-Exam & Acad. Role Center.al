page 69252 "ACA-Exam & Acad. Role Center"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            group(general)
            {
#pragma warning disable AL0269
                part("StudentsList"; "ACA-Std Card List")
#pragma warning restore AL0269
                {
                    Caption = 'Students List';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            group("General Setups")
            {
                Caption = 'Setups';
                action("Process Marks")
                {
                    Caption = 'Process Marks';
                    Image = AddAction;
                    
                    
                    RunObject = Page 77717;
                    ApplicationArea = All;
                }
                group(SetupsG)
                {
                    Caption = 'General Setups';
                    Image = Administration;
                    action(Programs)
                    {
                        Caption = 'Programs';
                        Image = FixedAssets;
                        
                        
                        
                        RunObject = Page 68757;
                        ApplicationArea = All;
                    }
                    action(Semesters)
                    {
                        Image = FixedAssetLedger;
                        
                        
                        RunObject = Page 68744;
                        ApplicationArea = All;
                    }
                    action("AcademicYear")
                    {
                        Image = Calendar;
                        
                        
                        RunObject = Page 68510;
                        ApplicationArea = All;
                    }
                    action("GeneralSetup")
                    {
                        Image = SetupLines;
                        
                        
                        RunObject = Page 68760;
                        ApplicationArea = All;
                    }
                    action("Modes of Study")
                    {
                        Image = Category;
                        
                        RunObject = Page 68739;
                        ApplicationArea = All;
                    }
                    action("Insurance Companies")
                    {
                        Image = Insurance;
                        
                        ApplicationArea = All;
                        // RunObject = Page 50051;
                    }
                    action("Application Setups")
                    {
                        Image = SetupList;
                        
                        RunObject = Page 68480;
                        ApplicationArea = All;
                    }
                    action("Admission Number Setup")
                    {
                        Image = SetupColumns;
                        
                        
                        RunObject = Page 68495;
                        ApplicationArea = All;
                    }
                    action("Admission Subjects")
                    {
                        Image = GeneralPostingSetup;
                        
                        RunObject = Page 68472;
                        ApplicationArea = All;
                    }
                    action("MarketingStrategies")
                    {
                        Image = MarketingSetup;
                        
                      //  RunObject = Page 50022;
                        ApplicationArea = All;
                    }
                    action("Import Data for Update")
                    {
                        Caption = 'Import Data for Update';
                        Image = ImportDatabase;
                        
                        
                        RunObject = Page 68929;
                        ApplicationArea = All;
                    }
                    action("Import Course Reg. Buffer")
                    {
                        Caption = 'Import Course Reg. Buffer';
                        Image = RegisterPutAway;
                        
                        
                        RunObject = Page 68900;
                        ApplicationArea = All;
                    }
                    action("Exam Setup")
                    {
                        Caption = '<Exam Setup>';
                        Image = SetupColumns;
                        
                        
                        RunObject = Page 68800;
                        ApplicationArea = All;
                    }
                    action("GradingSystem")
                    {
                        Image = Setup;
                        
                        RunObject = Page 68830;
                        ApplicationArea = All;
                    }
                    action("Lecturer List")
                    {
                        Image = Employee;
                        
                        
                        
                        RunObject = Page 68766;
                        ApplicationArea = All;
                    }
                    action("Import Units")
                    {
                        Caption = 'Import Units';
                        Image = ImportCodes;
                        
                        
                        ApplicationArea = All;
                        // RunObject = XMLport 50155;
                    }
                    action("Import Units (Buffered)")
                    {
                        Caption = 'Import Units (Buffered)';
                        Image = ImportLog;
                        
                        
                        RunObject = Page 68938;
                        ApplicationArea = All;
                    }
                }
                action("Schools Management")
                {
                    Caption = 'Schools Management';
                    Image = DistributionGroup;
                    
                    
                    RunObject = Page 77731;
                    ApplicationArea = All;
                }
            }
            group("Application and Admission")
            {
                group(AppliAdmin)
                {
                    Caption = 'Applications & General setup';
                    Image = Job;
                    action("Online Enquiries")
                    {
                        Image = NewOrder;
                        
                        
                        RunObject = Page 68292;
                        ApplicationArea = All;
                    }
                    action("Online Applications")
                    {
                        Image = NewCustomer;
                        
                        
                     //   RunObject = Page 50021;
                        ApplicationArea = All;
                    }
                    action("Admission Applications")
                    {
                        Image = NewCustomer;
                        
                        
                        RunObject = Page 50059;
                        ApplicationArea = All;
                    }
                    action("Approved Applications")
                    {
                        Image = Archive;
                        
                        RunObject = Page 68011;
                        ApplicationArea = All;
                    }
                    action("Admission Letters")
                    {
                        Image = CustomerList;
                        
                        
                        RunObject = Page 68515;
                        ApplicationArea = All;
                    }
                    action("Admitted Applicants")
                    {
                        Image = Archive;
                        
                        
                        RunObject = Page 68010;
                        ApplicationArea = All;
                    }
                }
            }
            group("Admission History")
            {
                group(AdminHist)
                {
                    Caption = 'Admissions History';
                    Image = History;
                    action("Pending Admissions")
                    {
                        Image = History;
                        
                        RunObject = Page 68483;
                        ApplicationArea = All;
                    }
                    action("Rejected Applications")
                    {
                        Image = Reject;
                        
                        RunObject = Page 68012;
                        ApplicationArea = All;
                    }
                    action("Cancelled Applications")
                    {
                        Image = Cancel;
                        
                        RunObject = Page 68009;
                        ApplicationArea = All;
                    }
                }
            }
            group("Admission Reports")
            {
                group(AdminReports)
                {
                    Caption = 'Admission Reports';
                    Image = ResourcePlanning;
                    action("Admissions Summary")
                    {
                        Caption = 'Admissions Summary';
                        Image = Report;
                        
                        
                        RunObject = Report 69285;
                        ApplicationArea = All;
                    }
                    action("Admission By Program")
                    {
                        Caption = 'Admission By Program';
                        Image = Report;
                        
                        
                        RunObject = Report 69286;
                        ApplicationArea = All;
                    }

                    action("New Applications")
                    {
                        Image = Report;
                        
                        
                        RunObject = Report 51352;
                        ApplicationArea = All;
                    }
                    action("Online Applications Report")
                    {
                        Image = Report;
                        
                        
                        RunObject = Report 51351;
                        ApplicationArea = All;
                    }
                    action(Enquiries)
                    {
                        Image = Report;
                        
                        
                        ApplicationArea = All;
                        //RunObject = Report 50052;
                    }
                    action("Marketing Strategies Report")
                    {
                        Image = Report;
                        
                        
                        ApplicationArea = All;
                        //RunObject = Report 50049;
                    }
                    action("Direct Applications")
                    {
                        Image = Report;
                        
                        
                        RunObject = Report 51379;
                        ApplicationArea = All;
                    }
                    action("Application List")
                    {
                        Image = Report;
                        
                        
                        RunObject = Report 51352;
                        ApplicationArea = All;
                    }
                    action("Application Summary")
                    {
                        Image = Report;
                        
                        
                        RunObject = Report 51350;
                        ApplicationArea = All;
                    }
                    action("Applicant Shortlisting (Summary)")
                    {
                        Image = Report;
                        
                        
                        RunObject = Report 51365;
                        ApplicationArea = All;
                    }
                    action("Applicant Shortlisting (Detailed)")
                    {
                        Image = Report;
                        
                        
                        RunObject = Report 51364;
                        ApplicationArea = All;
                    }
                }
            }
            group(Academics)
            {
                group(Academics2)
                {
                    Caption = 'Academic';
                    Image = Departments;
                    action("Student Registration")
                    {
                        Image = Register;
                        
                        
                        
                        RunObject = Page 68836;
                        ApplicationArea = All;
                    }
                    action("Student Card")
                    {
                        Image = Registered;
                        
                        
                        
                        RunObject = Page 68837;
                        ApplicationArea = All;
                    }
                    action(Alumni)
                    {
                        Image = History;
                        
                        
                        RunObject = Page 68974;
                        ApplicationArea = All;
                    }
                    action("Lecturers List")
                    {
                        Image = Resource;
                        
                        RunObject = Page 68853;
                        ApplicationArea = All;
                    }
                }
            }
            group("PeriodicActivities")
            {
                group(PerAc)
                {
                    Caption = 'Periodic Activities';
                    Image = Transactions;
                    action("Graduation Charges (Unposted)")
                    {
                        Caption = 'Graduation Charges (Unposted)';
                        Image = UnApply;
                        
                        
                        RunObject = Page 68420;
                        ApplicationArea = All;
                    }
                    action(GenGraduInd)
                    {
                        Caption = 'Generate Graduation Charges (Individual Students)';
                        Image = GetEntries;
                        
                        
                        RunObject = Report 51792;
                        ApplicationArea = All;
                    }
                }
            }
            group("Academic reports")
            {
                group(AcadReports)
                {
                    Caption = 'Academic reports';
                    Image = RegisteredDocs;
                    action("NorminalRoll")
                    {
                        Image = Report;
                        
                        
                        RunObject = Report 51765;
                        ApplicationArea = All;
                    }
                    action("Enrollment Statistics")
                    {
                        Image = Report;
                        
                        
                        RunObject = Report 51669;
                        ApplicationArea = All;
                    }
                    action("Student Balances")
                    {
                        Image = Report;
                        
                        
                        RunObject = Report 51393;
                        ApplicationArea = All;
                    }
                    action("Fee Statements")
                    {
                        Image = Report;
                        
                        
                        RunObject = Report 51072;
                        ApplicationArea = All;
                    }
                    action("Statistics By Programme Category")
                    {
                        Image = Statistics;
                        
                        
                        RunObject = Report 51779;
                        ApplicationArea = All;
                    }
                }
                action("Registered Units Summary")
                {
                    Caption = 'Registered Units Summary';
                    Image = SuggestLines;
                    
                    
                    RunObject = Report 64100;
                    ApplicationArea = All;
                }
            }
            group(ExamPeriodicA)
            {
                Caption = 'Exam Periodic Activities';
                Image = Confirm;
                group("Periodic Activities")
                {
                    Caption = 'Periodic Activities';
                    action("Raw Marks")
                    {
                        Caption = 'Raw Marks';
                        Image = ImportExcel;
                        
                        RunObject = Page 68901;
                        ApplicationArea = All;
                    }
                    action("Exam Results Buffer")
                    {
                        Caption = 'Exam Results Buffer';
                        Image = UserSetup;
                        RunObject = Page 69023;
                        ApplicationArea = All;
                    }
                    action("StudList")
                    {
                        Caption = 'Students List';
                        Image = UserSetup;
                        RunObject = Page 69024;
                        ApplicationArea = All;
                    }
                    action("Export Template")
                    {
                        Caption = 'Export Template';
                        Image = Export;
                        
                        
                        ApplicationArea = All;
                        // RunObject = XMLport 39005508;
                    }

                    action("Validate Exam Marks")
                    {
                        Caption = 'Validate Exam Marks';
                        Image = ValidateEmailLoggingSetup;
                        
                        
                        RunObject = Report 51149;
                        ApplicationArea = All;
                    }
                    action("Check Marks")
                    {
                        Caption = 'Check Marks';
                        Image = CheckList;
                        
                        
                        RunObject = Report 51771;
                        ApplicationArea = All;
                    }
                    action(Timetables)
                    {
                        Caption = 'Timetable';
                        Image = Template;
                        
                        RunObject = Page 69028;
                        ApplicationArea = All;
                    }
                    action(Examiners)
                    {
                        Caption = 'Examiners';
                        Image = HRSetup;
                        
                        RunObject = Page 69031;
                        ApplicationArea = All;
                    }
                }
            }
            group("Time Table1")
            {
                Caption = 'Time Tabling';
                Image = Setup;
                group(TimeTable)
                {
                    Caption = 'TimeTable Setups';
                    Image = Statistics;
                    action(Lessons)
                    {
                        Caption = 'Lessons';
                        Image = ListPage;
                        //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                        //
                        RunObject = Page 68769;
                        ApplicationArea = All;
                    }
                    action(Buildings)
                    {
                        Caption = 'Buildings';
                        Image = ListPage;
                        //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                        //
                        RunObject = Page 68745;
                        ApplicationArea = All;
                    }
                    action(Days)
                    {
                        Caption = 'Days';
                        Image = ListPage;
                        //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                        //
                        RunObject = Page 68740;
                        ApplicationArea = All;
                    }
                }
                group("Time Table")
                {
                    Caption = 'Time Tabling';
                    Image = Statistics;
                    action("Automatic Timetable")
                    {
                        Caption = 'Automatic Timetable';
                        Image = ListPage;
                        //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                        //
                        RunObject = Page 68129;
                        ApplicationArea = All;
                    }
                    action("Manual Timetable")
                    {
                        Caption = 'Manual Timetable';
                        Image = ListPage;
                        //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                        //
                        RunObject = Page 68798;
                        ApplicationArea = All;
                    }
                    action("Semi Auto Time Table")
                    {
                        Caption = 'Semi Auto Time Table';
                        Image = ListPage;
                        //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                        //
                        RunObject = Page 68729;
                        ApplicationArea = All;
                    }
                }
            }
            group("Time TableReports")
            {
                Caption = 'Time Table Reports';
                Image = Transactions;
                group("Time Table Reports")
                {
                    Caption = 'Time Table Reports';
                    action(Master)
                    {
                        Caption = 'Master';
                        Image = Report2;
                        //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                        //
                        RunObject = Report 51636;
                        ApplicationArea = All;
                    }
                    action(Individual)
                    {
                        Caption = 'Individual';
                        Image = Report2;
                        //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                        //
                        RunObject = Report 51530;
                        ApplicationArea = All;
                    }
                    action(Stage)
                    {
                        Caption = 'Stage';
                        Image = Report2;
                        //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                        //
                        RunObject = Report 51531;
                        ApplicationArea = All;
                    }
                    action(TT)
                    {
                        Caption = 'TT';
                        Image = Report2;
                        //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                        //
                        RunObject = Report 51637;
                        ApplicationArea = All;
                    }
                    action(Lecturer)
                    {
                        Caption = 'Lecturer';
                        Image = Report2;
                        //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                        //
                        RunObject = Report 51533;
                        ApplicationArea = All;
                    }
                    action(Exam)
                    {
                        Caption = 'Exam';
                        Image = Report2;
                        //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                        //
                        RunObject = Report 51534;
                        ApplicationArea = All;
                    }
                    action(Course)
                    {
                        Caption = 'Course';
                        Image = Report2;
                        //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                        //
                        RunObject = Report 51549;
                        ApplicationArea = All;
                    }
                    action("Course 2")
                    {
                        Caption = 'Course 2';
                        Image = Report2;
                        //The property 'PromotedIsBig' can only be set if the property 'Promoted' is set to 'true'
                        //
                        RunObject = Report 51551;
                        ApplicationArea = All;
                    }
                }
            }
            group("ExamSetups")
            {
                Caption = 'Exam Setups';
                Image = HRSetup;
            }
            group(Setup)
            {
                Caption = 'Setups';
                action("Exam Setups")
                {
                    Caption = 'Exam Setups';
                    Image = SetupLines;
                    
                    RunObject = Page 68800;
                    ApplicationArea = All;
                }
                action("GradSystem")
                {
                    Caption = 'Grading System';
                    Image = Setup;
                    
                   
                    RunObject = Page 68830;
                    ApplicationArea = All;
                }
                action("Lecturers Units")
                {
                    Caption = 'Lecturers Units';
                    Image = VendorLedger;
                    
                    RunObject = Page 68766;
                    ApplicationArea = All;
                }
                action("General Setup")
                {
                    Caption = 'General Setup';
                    Image = GeneralPostingSetup;
                    
                    RunObject = Page 68760;
                    ApplicationArea = All;
                }
                action("Academic Year")
                {
                    Caption = 'Academic Year';
                    Image = Calendar;
                    
                    RunObject = Page 68509;
                    ApplicationArea = All;
                }
                action("Results Status List")
                {
                    Caption = 'Results Status List';
                    Image = Status;
                    RunObject = Page 68244;
                    ApplicationArea = All;
                }
                action("Classification Lubrics")
                {
                    Caption = 'Classification Lubrics';
                    Image = AddWatch;
                    
                    
                    RunObject = Page 78011;
                    ApplicationArea = All;
                }
                action("Supplementary Lubrics")
                {
                    Caption = 'Supplementary Lubrics';
                    Image = StepInto;
                    RunObject = Page 78015;
                    ApplicationArea = All;
                }
            }
        }
        area(Creation)
        {
            group("Student Management Setups")
            {
                Caption = 'Academic Setups';
                action("Bulk Units Registration")
                {
                    Caption = 'Bulk Units Registration';
                    RunObject = Page 77750;
                    ApplicationArea = All;
                }
                action("Gratuation Overview")
                {
                    Caption = 'Gratuation Overview';
                    RunObject = Page 78021;
                    ApplicationArea = All;
                }
                action("program List")
                {
                    Caption = 'program List';
                    Image = FixedAssets;
                    
                    
                    
                    RunObject = Page 68757;
                    ApplicationArea = All;
                }
                action("Semester Setup")
                {
                    Caption = 'Semester Setup';
                    Image = FixedAssetLedger;
                    
                    
                    RunObject = Page 68744;
                    ApplicationArea = All;
                }
                action("Academic Year Manager")
                {
                    Caption = 'Academic Year Manager';
                    Image = Calendar;
                    
                    
                    RunObject = Page 68510;
                    ApplicationArea = All;
                }
                action("Inter Transfers")
                {
                    RunObject = Page 61612;
                    ApplicationArea = All;
                }
            }
            group("Applications/Admissions")
            {
                action("Applications (Online)")
                {
                    Image = NewCustomer;
                    
                    
                    RunObject = Page 68864;
                    ApplicationArea = All;
                }
                action("Applications - Direct ")
                {
                    Image = NewCustomer;
                    
                    
                    RunObject = Page 68848;
                    ApplicationArea = All;
                }
                action("Applicant Admission Letters")
                {
                    Image = CustomerList;
                    
                    
                    RunObject = Page 68515;
                    ApplicationArea = All;
                }
                action("Admissions (New)")
                {
                    Image = NewItem;
                    
                    
                    RunObject = Page 68850;
                    ApplicationArea = All;
                }
            }
            group("General Academics")
            {
                action(Registration2)
                {
                    Image = Register;
                    
                    
                    
                    RunObject = Page 68836;
                    ApplicationArea = All;
                }
                action("Students Card2")
                {
                    Image = Registered;
                    
                    
                    
                    RunObject = Page 68837;
                    ApplicationArea = All;
                }
            }
            group(Examinations)
            {
                action("Students List")
                {
                    Caption = 'Students List';
                    Image = UserSetup;
                    RunObject = Page 69024;
                    ApplicationArea = All;
                }
                action("Grading System")
                {
                    Caption = 'Grading System';
                    Image = SetupColumns;
                    
                    RunObject = Page 68830;
                    ApplicationArea = All;
                }
            }
        }
        area(sections)
        {
            group("PSSP Admissions")
            {
                Caption = 'PSSP Admissions';
                Image = RegisteredDocs;
                action("Enquiry list")
                {
                    Caption = 'Enquiry list';
                    RunObject = Page 68293;
                    ApplicationArea = All;
                }
                action("Enquiry List (Pending)")
                {
                    Caption = 'Enquiry List (Pending)';
                    RunObject = Page 69200;
                    ApplicationArea = All;
                }
                action("Enquiry List (Rejected)")
                {
                    Caption = 'Enquiry List (Rejected)';
                    RunObject = Page 69201;
                    ApplicationArea = All;
                }
                action(Applications)
                {
                    Caption = 'Applications';
                    RunObject = Page 68848;
                    ApplicationArea = All;
                }
                action("Dean's Commitee")
                {
                    Caption = 'Dean''s Commitee';
                    RunObject = Page 68487;
                    Visible = false;
                    ApplicationArea = All;
                }
                action("Admissionslist")
                {
                    Caption = 'Admissions letters list';
                    RunObject = Page 68524;
                    Visible = true;
                    ApplicationArea = All;
                }
                action("pendingDocverification")
                {
                    Caption = 'pending documents verification';
                    RunObject = Page 68483;
                    Visible = true;
                    ApplicationArea = All;
                }
                action("pending paymentsconfirmation")
                {
                    Caption = 'pending payments confirmation';
                    RunObject = Page 68522;
                    ApplicationArea = All;
                }
                action("pending Admissionconfirmation")
                {
                    Caption = 'pending Admission confirmation';
                    RunObject = Page 68523;
                    ApplicationArea = All;
                }
                action("Admitted Students")
                {
                    Caption = 'Admitted Students';
                    RunObject = Page 68010;
                    ApplicationArea = All;
                }
            }
            group("KUCCPS Admission")
            {
                Caption = 'KUCCPS Admission';
                Image = Transactions;
                action("Raw KUCCPS Data")
                {
                    Caption = 'Raw KUCCPS Data';
                    Image = ImportLog;
                    
                    
                    RunObject = Page 62200;
                    ApplicationArea = All;
                }
                action("Import Jab Admissions")
                {
                    Caption = 'Import Jab Admissions';
                    RunObject = Page 68491;
                    ApplicationArea = All;
                }
                action("Processed Jab Admissions")
                {
                    Caption = 'Processed Jab Admissions';
                    RunObject = Page 78132;
                    ApplicationArea = All;
                }
                action("Admissions letters list")
                {
                    Caption = 'Admissions letters list';
                    RunObject = Page 68524;
                    ApplicationArea = All;
                }
                action("pending documents verification")
                {
                    Caption = 'pending documents verification';
                    RunObject = Page 68483;
                    ApplicationArea = All;
                }
                action("pending payments confirmation")
                {
                    Caption = 'pending payments confirmation';
                    RunObject = Page 68522;
                    ApplicationArea = All;
                }
                action("pending Admission confirmation")
                {
                    Caption = 'pending Admission confirmation';
                    RunObject = Page 68523;
                    ApplicationArea = All;
                }
                action("<Page ACA-Admitted Applicants Li2")
                {
                    Caption = 'Admitted Students';
                    RunObject = Page 68010;
                    ApplicationArea = All;
                }
            }
            group("Students Management")
            {
                Caption = 'Students Management';
                Image = ResourcePlanning;
                action(Registration)
                {
                    Image = Register;
                    
                    
                    
                    RunObject = Page 68836;
                    ApplicationArea = All;
                }
                action("Students Card")
                {
                    Image = Registered;
                    
                    
                    
                    RunObject = Page 68837;
                    ApplicationArea = All;
                }
                action(Programm)
                {
                    Caption = 'Programmes';
                    RunObject = Page 68757;
                    ApplicationArea = All;
                }
                action("Signing of Norminal Role")
                {
                    Caption = 'Signing of Norminal Role';
                    RunObject = Page 68238;
                    ApplicationArea = All;
                }
                action("Class Allocations")
                {
                    Image = Allocate;
                    RunObject = Page 68417;
                    ApplicationArea = All;
                }
            }
            group(LectMan)
            {
                Caption = 'Lecturer Management';
                Image = HumanResources;
                action(SemBatches)
                {
                    Caption = 'Lect. Loading Semester Batches';
                    Image = Register;
                    
                    
                    
                    RunObject = Page 65210;
                    ApplicationArea = All;
                }
                action(LoadApp)
                {
                    Caption = 'Loading Approvals';
                    Image = Registered;
                    
                    
                    
                    RunObject = Page 65215;
                    ApplicationArea = All;
                }
                action(ApprovedLoad)
                {
                    Caption = 'Approved Loading';
                    RunObject = Page 65227;
                    ApplicationArea = All;
                }
                action(ClaimsGen)
                {
                    Caption = 'Lect. Claim Generation';
                    RunObject = Page 65216;
                    ApplicationArea = All;
                }
                action(LoadPendingDeptApp)
                {
                    Caption = 'Loading Pending Dept. Approval';
                    Image = Registered;
                    
                    
                    
                    RunObject = Page 65226;
                    ApplicationArea = All;
                }
                action(PostedSemBatches)
                {
                    Caption = 'Posted Load Batches';
                    RunObject = Page 65217;
                    ApplicationArea = All;
                }
                action(LoadHist)
                {
                    Caption = 'Loading History';
                    RunObject = Page 65225;
                    ApplicationArea = All;
                }
                action(LoadCentralSetup)
                {
                    Caption = 'Loading Central Setup';
                    Image = Registered;
                    
                    
                    
                    RunObject = Page 65204;
                    ApplicationArea = All;
                }
            }
            group(Timetabling)
            {
                Caption = 'Timetable Management';
                Image = Statistics;
                action(TimetableCentral)
                {
                    Caption = 'Timetable Central';
                    Image = Register;
                    
                    
                    
                    RunObject = Page 74500;
                    ApplicationArea = All;
                }
                action("Exam Timetable")
                {
                    Caption = 'Exam Timetable';
                    RunObject = Page 74550;
                    ApplicationArea = All;
                }
            }
            group(Clearances)
            {
                Caption = 'Student Clearance';
                Image = Intrastat;
                action(OpenClearance)
                {
                    Caption = 'Student Clearance (Open)';
                    Image = Register;
                    
                    
                    
                    RunObject = Page 68971;
                    ApplicationArea = All;
                }
                action(ActiveClearance)
                {
                    Caption = 'Student Clearance (Active)';
                    Image = Registered;
                    
                    
                    
                    RunObject = Page 68972;
                    ApplicationArea = All;
                }
                action(Cleared)
                {
                    Caption = 'Student Clearance(Cleared)';
                    RunObject = Page 68973;
                    ApplicationArea = All;
                }
                action(AllumniList)
                {
                    Caption = 'Student Aluminae List';
                    RunObject = Page 68974;
                    ApplicationArea = All;
                }
            }
            group(Setups)
            {
                Caption = 'Setups';
                Image = Setup;
                action(Programmes)
                {
                    Caption = 'Programmes';
                    RunObject = Page 68757;
                    ApplicationArea = All;
                }
                action(Nationality)
                {
                    Caption = 'Nationality';
                    RunObject = Page 68868;
                    ApplicationArea = All;
                }
                action("Marketing Strategies")
                {
                    Caption = 'Marketing Strategies';
                    RunObject = Page 68865;
                    ApplicationArea = All;
                }
                action("Schools/Faculties")
                {
                    Caption = 'Schools/Faculties';
                    RunObject = Page 68832;
                    ApplicationArea = All;
                }
                action(Religions)
                {
                    Caption = 'Religions';
                    RunObject = Page 68841;
                    ApplicationArea = All;
                }
                action(Denominations)
                {
                    Caption = 'Denominations';
                    RunObject = Page 68842;
                    ApplicationArea = All;
                }
                action("InsurCompanies")
                {
                    Caption = 'Insurance Companies';
                    ApplicationArea = All;
                    //   RunObject = Page 68844;
                }
                action(Relationships)
                {
                    Caption = 'Relationships';
                    RunObject = Page 68845;
                    ApplicationArea = All;
                }
                action(Counties)
                {
                    Caption = 'Counties';
                    RunObject = Page 68871;
                    ApplicationArea = All;
                }
                action("Clearance Codes")
                {
                    Caption = 'Clearance Codes';
                    Image = Setup;
                    RunObject = Page 68966;
                    ApplicationArea = All;
                }
                action("Registration List")
                {
                    Image = Allocations;
                    RunObject = Page 69187;
                    ApplicationArea = All;
                }
            }
            group(Approvals)
            {
                Caption = 'Approvals';
                Image = Alerts;
                action("Pending My Approval")
                {
                    Caption = 'Pending My Approval';
                    RunObject = Page "Approval Entries";
                    ApplicationArea = All;
                }
                action("My Approval requests")
                {
                    Caption = 'My Approval requests';
                    RunObject = Page "Approval Request Entries";
                    ApplicationArea = All;
                }
                action("Clearance Requests")
                {
                    Caption = 'Clearance Requests';
                    RunObject = Page "ACA-Clearance Approval Entries";
                    ApplicationArea = All;
                }
            }
            /*  group(Common_req)
             {
                 Caption = 'Common Requisitions';
                 Image = LotInfo;
                 action("Stores Requisitions")
                 {
                     Caption = 'Stores Requisitions';
                     RunObject = Page 68218;
                 }
                 action("Imprest Requisitions")
                 {
                     Caption = 'Imprest Requisitions';
                     RunObject = Page 68125;
                 }
                 action("Leave Applications")
                 {
                     Caption = 'Leave Applications';
                     RunObject = Page 68107;
                 }
                 action("Purchase Requisitions")
                 {
                     Caption = 'Purchase Requisitions';
                     RunObject = Page 68217;
                 }
                 action("My Approved Leaves")
                 {
                     Caption = 'My Approved Leaves';
                     Image = History;
                     RunObject = Page 68232;
                 }
                 action("File Requisitions")
                 {
                     Image = Register;
                     
                     RunObject = Page 69183;
                 }
                 action("Meal Booking")
                 {
                     Caption = 'Meal Booking';
                     RunObject = Page 69302;
                 }
             } */
        }
        area(reporting)
        {
            group(Periodic)
            {
                Caption = 'Periodic Reports';
                group(AcadReports2)
                {
                    Caption = 'Academic Reports';
                    Image = AnalysisView;
                    action("All Students")
                    {
                        Image = Report2;
                        RunObject = Report 51466;
                        ApplicationArea = All;
                    }
                    action("Norminal Roll")
                    {
                        Caption = 'Norminal Roll';
                        Image = Report2;
                        RunObject = Report 51765;
                        ApplicationArea = All;
                    }
                    action("Class List (By Stage)")
                    {
                        Caption = 'Class List (By Stage)';
                        Image = List;
                        
                        
                        RunObject = Report 51767;
                        ApplicationArea = All;
                    }
                    action("Signed Norminal Roll")
                    {
                        Caption = 'Signed Norminal Roll';
                        Image = Report2;
                        
                        RunObject = Report 51134;
                        ApplicationArea = All;
                    }
                    action("Program List By Gender && Type")
                    {
                        Caption = 'Program List By Gender && Type';
                        Image = PrintReport;
                        
                        
                        RunObject = Report 51780;
                        ApplicationArea = All;
                    }
                    action("population By Faculty")
                    {
                        Caption = 'population By Faculty';
                        Image = PrintExcise;
                        
                        
                        RunObject = Report 51781;
                        ApplicationArea = All;
                    }
                    action("Multiple Record")
                    {
                        Caption = 'Multiple Record';
                        Image = Report2;
                        RunObject = Report 51770;
                        ApplicationArea = All;
                    }
                    action("Classification By Campus")
                    {
                        Caption = 'Classification By Campus';
                        Image = Report2;
                        RunObject = Report 51776;
                        ApplicationArea = All;
                    }
                    action("Population By Campus")
                    {
                        Caption = 'Population By Campus';
                        Image = Report2;
                        RunObject = Report 51777;
                        ApplicationArea = All;
                    }
                    action("Population by Programme")
                    {
                        Caption = 'Population by Programme';
                        Image = Report2;
                        RunObject = Report 51778;
                        ApplicationArea = All;
                    }
                    action("Prog. Category")
                    {
                        Caption = 'Prog. Category';
                        Image = Report2;
                        RunObject = Report 51779;
                        ApplicationArea = All;
                    }
                    action("List By Programme")
                    {
                        Caption = 'List By Programme';
                        Image = Report;
                        RunObject = Report 51766;
                        ApplicationArea = All;
                    }
                    action("List By Programme (With Balances)")
                    {
                        Caption = 'List By Programme (With Balances)';
                        Image = PrintReport;
                        
                        
                        RunObject = Report 51768;
                        ApplicationArea = All;
                    }
                    action("Type. Study Mode, & Gender")
                    {
                        Caption = 'Type. Study Mode, & Gender';
                        Image = Report;
                        RunObject = Report 51785;
                        ApplicationArea = All;
                    }
                    action("Study Mode & Gender")
                    {
                        Caption = 'Study Mode & Gender';
                        Image = Report;
                        RunObject = Report 51786;
                        ApplicationArea = All;
                    }
                    action("County & Gender")
                    {
                        Caption = 'County & Gender';
                        Image = Report;
                        RunObject = Report 51788;
                        ApplicationArea = All;
                    }
                    action("List By County")
                    {
                        Caption = 'List By County';
                        Image = Report;
                        RunObject = Report 51789;
                        ApplicationArea = All;
                    }
                    action("Prog. Units")
                    {
                        Caption = 'Prog. Units';
                        Image = Report;
                        RunObject = Report 51203;
                        ApplicationArea = All;
                    }
                    action("Enrollment By Stage")
                    {
                        Caption = 'Enrollment By Stage';
                        Image = Report2;
                        RunObject = Report 51545;
                        ApplicationArea = All;
                    }
                    action("ImportUnits")
                    {
                        Caption = 'Import Units';
                        Image = ImportExcel;
                        
                        
                        RunObject = Page 68938;
                        ApplicationArea = All;
                    }
                    action("Hostel Allocations")
                    {
                        Caption = 'Hostel Allocations';
                        Image = PrintCover;
                        
                        
                        RunObject = Report 51719;
                        ApplicationArea = All;
                    }
                    action("Students List (By Program)")
                    {
                        Caption = 'Students List (By Program)';
                        Image = Report;
                        
                        
                        RunObject = Report 51820;
                        ApplicationArea = All;
                    }
                    action("Programme Units")
                    {
                        Caption = 'Programme Units';
                        Image = Report;
                        
                        RunObject = Report 51203;
                        ApplicationArea = All;
                    }
                    action("CUE Report")
                    {
                        Caption = 'CUE Report';
                        Image = AddAction;
                        
                        RunObject = Report 63905;
                        ApplicationArea = All;
                    }
                }
                group("BeforeExams")
                {
                    Caption = 'Before Exams';
                    action("ExaminationCards")
                    {
                        Caption = 'Examination Cards';
                        Image = Card;
                        
                        
                        RunObject = Report 51774;
                        ApplicationArea = All;
                    }
                    action("Exam CardStickers")
                    {
                        Caption = 'Exam Card Stickers';
                        Image = Split;
                        
                        RunObject = Report 51775;
                        ApplicationArea = All;
                    }
                    action("Class attendance With B")
                    {
                        RunObject = Report 51580;
                        ApplicationArea = All;
                    }
                    action("Class Attendance Without B")
                    {
                        RunObject = Report 51594;
                        ApplicationArea = All;
                    }
                    action("Aca-Special Exams Check List")
                    {
                        Image = Print;
                        RunObject = Report 51597;
                        ApplicationArea = All;
                    }
                }
                group("Students Finance Reports")
                {
                    Image = Statistics;
                    action("Students Balances")
                    {
                        Image = PrintInstallment;
                        
                        RunObject = Report 51481;
                        ApplicationArea = All;
                    }
                    action("Per Programme Balances")
                    {
                        Image = PrintInstallment;
                        
                        RunObject = Report 51485;
                        ApplicationArea = All;
                    }
                    action("Per Stage Balances")
                    {
                        Image = PrintInstallment;
                        RunObject = Report 51493;
                        ApplicationArea = All;
                    }
                    action("Students Faculty Income Summary")
                    {
                        Image = PrintInstallment;
                        RunObject = Report 51482;
                        ApplicationArea = All;
                    }
                    action("Student Invoices Per Charge")
                    {
                        Caption = 'Student Invoices Per Charge';
                        Image = PrintInstallment;
                        
                        
                        RunObject = Report 51747;
                        ApplicationArea = All;
                    }
                    action("Fee Structure Report")
                    {
                        Caption = 'Fee Structure Report';
                        Image = Report;
                        RunObject = Report 51794;
                        ApplicationArea = All;
                    }
                    action("Student Receipts per Charge")
                    {
                        Caption = 'Student Receipts per Charge';
                        Image = PrintReport;
                        
                        
                        RunObject = Report 51748;
                        ApplicationArea = All;
                    }
                }
                group("Before Exams")
                {
                    Caption = 'Before Exams';
                    Image = Report;
                    action("Examination Cards")
                    {
                        Caption = 'Examination Cards';
                        Image = Card;
                        
                        
                        RunObject = Report 51515;
                        ApplicationArea = All;
                    }
                    action("Exam Card Stickers")
                    {
                        Caption = 'Exam Card Stickers';
                        Image = Split;
                        
                        RunObject = Report 51775;
                        ApplicationArea = All;
                    }
                }
                action("Course Loading")
                {
                    Caption = 'Course Loading';
                    Image = LineDiscount;
                    
                    
                    RunObject = Report 69270;
                    ApplicationArea = All;
                }
                action("Class attendance With BA")
                {
                    RunObject = Report 51580;
                    ApplicationArea = All;
                }
                action("Class Attendance Without BA")
                {
                    RunObject = Report 51594;
                    ApplicationArea = All;
                }
                action("Resits Collection Report")
                {
                    Image = Print;
                    RunObject = Report 78003;
                    ApplicationArea = All;
                }
                action("Aca-Special Exams Check Ls")
                {
                    Image = Print;
                    RunObject = Report 51597;
                    ApplicationArea = All;
                }
                group(ExamExams)
                {
                    Caption = 'After Exams';
                    Image = Report;
                    action("Consolidated Marksheet")
                    {
                        Caption = 'Consolidated Marksheet';
                        Image = Completed;
                        
                        RunObject = Report 51587;
                        ApplicationArea = All;
                    }
                    action("Consolidated Marksheet 2")
                    {
                        Caption = 'Consolidated Marksheet 2';
                        Image = CompleteLine;
                        
                        RunObject = Report 51798;
                        ApplicationArea = All;
                    }
                    action("Consolidated Marksheet 3")
                    {
                        Caption = 'Consolidated Marksheet 3';
                        RunObject = Report 51698;
                        Visible = false;
                        ApplicationArea = All;
                    }
                    action("Senate Summary Report 1")
                    {
                        Caption = 'Senate Summary Report 1';
                        Image = Report;
                        
                        
                        RunObject = Report 51565;
                        ApplicationArea = All;
                    }
                    action("Senate Summary Report 2")
                    {
                        Caption = 'Senate Summary Report 2';
                        Image = Report;
                        
                        
                        RunObject = Report 81800;
                        ApplicationArea = All;
                    }
                    action(Attendance_Checklist)
                    {
                        Caption = 'Attendance Checklist';
                        RunObject = Report 51577;
                        ApplicationArea = All;
                    }
                    action("Class Grade Sheet")
                    {
                        Caption = 'Class Grade Sheet';
                        Image = CheckDuplicates;
                        
                        RunObject = Report 51799;
                        Visible = false;
                        ApplicationArea = All;
                    }
                    action("Consolidated Gradesheet")
                    {
                        Caption = 'Consolidated Gradesheet';
                        Image = CheckDuplicates;
                        
                        RunObject = Report 51800;
                        Visible = false;
                        ApplicationArea = All;
                    }
                    action("Provisional Transcript")
                    {
                        Caption = 'Provisional Transcript';
                        Image = FixedAssets;
                        
                        RunObject = Report 51772;
                        ApplicationArea = All;
                    }
                    action("Official Transcript")
                    {
                        Caption = 'Official Transcript';
                        Image = Split;
                        
                        RunObject = Report 51773;
                        ApplicationArea = All;
                    }
                    action("Marks Entry Statistics")
                    {
                        Caption = 'Marks Entry Statistics';
                        Image = AgreementQuote;
                        RunObject = Report 69276;
                        ApplicationArea = All;
                    }
                    action("Confirmation Marksheet")
                    {
                        Caption = 'Confirmation Marksheet';
                        Image = AdjustEntries;
                        RunObject = Report 51771;
                        ApplicationArea = All;
                    }
                    action("Student Progress Report")
                    {
                        Caption = 'Student Progress Report';
                        Image = Agreement;
                        RunObject = Report 51801;
                        ApplicationArea = All;
                    }
                }
            }
        }
    }
}

