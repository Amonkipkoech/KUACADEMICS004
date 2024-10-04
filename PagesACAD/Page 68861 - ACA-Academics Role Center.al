/// <summary>
/// Page ACA-Academics Role Center (ID 68861).
/// </summary>
page 68861 "ACA-Academics Role Center"
{
    Caption = 'Role Center';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part("Dashboard Greetings"; "Dashboard Greetings")

            {
                ApplicationArea = all;
            }
            part(ApprovalsActivities; "Approvals Activities")
            {
                ApplicationArea = Suite;
            }
            group(contrl)
            {
#pragma warning disable AL0269
                part("Students List"; "ACA-Std Card List")
#pragma warning restore AL0269
                {
                    ApplicationArea = All;
                    Caption = 'Students List';
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
                    }//"ACA-Academics departments"
                     // action(ChangePassword)
                     // {
                     //     ApplicationArea = Basic, Suite;
                     //     Caption = 'Change &Password';
                     //     Image = EncryptionKeys;

                    //     ToolTip = 'Change the user''s password if the user connects using password authentication.';
                    //     Visible = not IsSaaS;

                    //     trigger OnAction()
                    //     begin
                    //         EditNavPassword;
                    //     end;
                    // }
                    action(changePassword)
                    {
                        ApplicationArea = All;
                        RunObject = Page "Users Custom";
                        Image = SocialSecurity;
                    }
                    action("Academic Departments")
                    {
                        Caption = 'Academic Departments';
                        Image = FixedAssets;

                        RunObject = Page "ACA-Academics departments";
                        ApplicationArea = All;
                    }//"ACA-Academics departments"
                    action(Semesters)
                    {
                        Image = FixedAssetLedger;


                        RunObject = Page 68744;
                        ApplicationArea = All;
                    }
                    action(Intakes)
                    {
                        Image = Customer;
                        RunObject = Page "ACA-Intake List";
                        ApplicationArea = ALL;
                    }
                    action(IntakeFee)
                    {
                        Image = CashFlow;
                        RunObject = Page "Program Intake Fee";
                        ApplicationArea = ALL;
                    }
                    action("PT Rates")
                    {
                        Image = CashFlow;
                        RunObject = Page "PT Rates";
                        ApplicationArea = ALL;
                    }
                    action("CRM Sections")
                    {
                        Image = CashFlow;
                        RunObject = Page "CRM-Sections";
                        ApplicationArea = ALL;
                    }
                    action(portalSetups)
                    {
                        Caption = 'Configure Portal Messages';
                        Image = Web;
                        RunObject = page "Portal Setups";
                        ApplicationArea = All;
                    }
                    action(Buildings)
                    {
                        Image = Insurance;


                        RunObject = Page "ACA-Buildings Setup";
                        ApplicationArea = All;
                    }
                    action(lecHalls)
                    {
                        Image = RefreshDiscount;


                        RunObject = Page "ACA-LectureHalls Setup";
                        ApplicationArea = All;
                    }
                    action("Academic Year")
                    {
                        Image = Calendar;


                        RunObject = Page 68510;
                        ApplicationArea = All;
                    }
                    action("General Setup")
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
                    action("Program Duration")
                    {
                        Image = Timeline;

                        RunObject = Page 86523;
                        ApplicationArea = All;
                    }
                    action("InsuranceCompanies")
                    {
                        Image = Insurance;

                        ApplicationArea = All;
                        //RunObject = Page 50051;
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
                    action("Academic Department")
                    {
                        Caption = 'Academic Departments';
                        Image = FixedAssets;

                        RunObject = Page "ACA-Academics departments";
                        ApplicationArea = All;
                    }//"ACA-Academics departments"
                    action("MarketingStrategies")
                    {
                        Image = MarketingSetup;

                        // RunObject = Page 50022;
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
                    action("Grading System")
                    {
                        Image = Setup;

                        RunObject = Page 68830;
                        ApplicationArea = All;
                    }
                    // action("Grading Sources")
                    // {
                    //     ApplicationArea = All;
                    //     Image = GetStandardJournal;
                    //     RunObject = page "ACA-Exam Grading Sources";
                    // }
                    action("Marksheet Submission")
                    {
                        Image = Receivables;
                        RunObject = Page "Marksheet Submission";
                        ApplicationArea = All;
                    }
                    action("Lecturer List")
                    {
                        Image = Employee;

                        RunObject = Page 68766;
                        ApplicationArea = All;
                    }
                    action("ImportUnits")
                    {
                        Caption = 'Import Units';
                        Image = ImportCodes;


                        ApplicationArea = All;
                        //  RunObject = XMLport 50155;
                    }
                    action("Import Units (Buffered)")
                    {
                        Caption = 'Import Units (Buffered)';
                        Image = ImportLog;


                        RunObject = Page "ACA-Prog. Units Buffer";
                        ApplicationArea = All;
                    }
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


                        //RunObject = Page 50021;
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


                        RunObject = Report 86663;
                        ApplicationArea = All;
                        //Visible = false;
                    }
                    action("Admission By Program")
                    {
                        Caption = 'Admission By Program';
                        Image = Report;


                        RunObject = Report 69286;
                        ApplicationArea = All;
                        Visible = false;
                    }
                    action("Admission Summary 2")
                    {
                        Caption = 'Admission Summary 2';
                        Image = Report;


                        ApplicationArea = All;
                        //  RunObject = Report 69287;
                        Visible = false;
                    }
                    action("New Applications")
                    {
                        Image = Report;
                        Caption = 'Applicants Summary Report';


                        RunObject = Report 86521;
                        ApplicationArea = All;
                    }
                    action("Student Programme Data")
                    {
                        Image = Report;
                        Caption = 'Students Programme Data';


                        RunObject = Report 86520;
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
                        RunObject = Report 50049;
                        ApplicationArea = All;
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
                    action(ClassSplits)
                    {
                        Image = Report;


                        RunObject = Report "Class Splits Reports";
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
            group("Periodic Activities")
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
                    action(ProcessGraduation)
                    {
                        //Caption = 'Generate Graduation Charges (Individual Students)';
                        Image = GetEntries;


                        RunObject = Report "Process Graduation";
                        ApplicationArea = All;
                    }
                    action("Graduating Students")
                    {
                        //Caption = 'Generate Graduation Charges (Individual Students)';
                        Image = GetEntries;


                        RunObject = page "Process Graduation";
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
                    action("Registered Students")
                    {
                        Image = Report;

                        RunObject = Report 51765;
                        ApplicationArea = All;
                    }
                    action("Admission Letter")
                    {
                        Image = Report;
                        RunObject = Report "Bachelors Admission Letter";
                        ApplicationArea = All;
                    }
                    action(suppStud)
                    {
                        Caption = 'Supp/Special Students';
                        Image = Report;
                        RunObject = Report SupplimentaryReport;
                        ApplicationArea = All;
                    }
                    action(Classlist)
                    {
                        Image = CalculateSalesTax;
                        RunObject = Report "ACA-Class List";
                        ApplicationArea = All;
                    }
                    // action(Classlist2)
                    // {
                    //     Image = CalculateSalesTax;
                    //     RunObject = Report "ACA-Class List (List By Stage)";
                    //     ApplicationArea = All;
                    // }
                    action("Students Registered Per Unit")
                    {
                        Image = Register;
                        RunObject = Report "Students Registered Per Unit";
                        ApplicationArea = All;
                    }
                    action("Transcript")
                    {
                        Image = Register;
                        RunObject = Report "Final Graduation Transcript";
                        ApplicationArea = All;
                    }
                    action("Graduation Tracker")
                    {
                        Image = Register;
                        RunObject = Report "Graduation Tracker";
                        ApplicationArea = All;
                    }
                    action("Semester Results")
                    {
                        Image = ResourceSkills;


                        RunObject = Report "Provisional Transcript2";
                        ApplicationArea = All;
                    }
                    action(examattendanceVC)
                    {
                        Caption = 'Exam Attendance';
                        Image = Report;
                        RunObject = Report 84509;
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
            }
        }
        area(embedding)
        {
            action("Reg Temp")
            {
                RunObject = page "ACA-Application RegTemp";
                ApplicationArea = All;
            }
            action(changePassword2)
            {
                ApplicationArea = All;
                RunObject = Page "Users Custom";
                Image = SocialSecurity;
                Caption = 'Change Password';
            }
            // action("g/l enrty Update")
            // {
            //     Image = Ledger;
            //     //Promoted = true;
            //     //PromotedCategory = Category4;
            //     //PromotedIsBig = true;
            //     RunObject = report updateGl;
            //     ApplicationArea = All;
            // }
            // action("g/l name Update")
            // {
            //     Image = Ledger;
            //     //Promoted = true;
            //     //PromotedCategory = Category4;
            //     //PromotedIsBig = true;
            //     RunObject = report updateGlacc;
            //     ApplicationArea = All;
            // }
            // action(coa)
            // {
            //     Image = ExpandAll;
            //     RunObject = page coaUpdate;
            //     ApplicationArea = All;
            // }
            action(examEnrty)
            {
                Caption = 'Exam Marks Report';
                Image = ExpandAll;
                RunObject = page "Exam Mark Entry";
                ApplicationArea = All;
                //Visible = false;
            }
            action("Program Leaders")
            {
                ApplicationArea = All;
                RunObject = page "Pogramme Leaders List";
                Caption = 'Pogramme Leaders List';

            }
            // action(dataC)
            // {
            //     RunObject = page calcStage;
            //     ApplicationArea = All;
            //     Visible = false;
            // }

            // action(RegData)
            // {
            //     Caption = 'Reg Data';
            //     RunObject = page CourseReg;
            //     ApplicationArea = All;
            // }
            // action(getProg)
            // {
            //     RunObject = page findProgram;
            //     ApplicationArea = All;
            //     Visible = false;
            // }
            // action(CleanUp)
            // {
            //     Caption = 'Reg Data';
            //     RunObject = page dataClean;
            //     ApplicationArea = All;
            // }

            action("program List")
            {
                Caption = 'Program List';
                Image = FixedAssets;



                RunObject = Page 68757;
                ApplicationArea = All;
            }
            action(loadStages)
            {
                Caption = 'Find Stages';
                Image = FixedAssets;



                RunObject = Page progStagesTest;
                ApplicationArea = All;
                Visible = false;
            }
            action("Units on Offer")
            {
                //Caption = 'Load Stages';
                Image = FixedAssets;



                RunObject = Page "ACA-Units Offered";
                ApplicationArea = All;
                //Visible = false;

            }
            action("Decomissioned Programs")
            {
                Image = FixedAssets;



                RunObject = page "ACA-Programmes Decomissioned";
                ApplicationArea = All;
            }
            action("Historical Transcript")
            {
                RunObject = Page "Historical Transcript Data";
                ApplicationArea = All;
            }
            action("Supplimentary/Specials")
            {
                RunObject = page "Supplimentary/Specials";
                ApplicationArea = All;
            }
            // action("Find Misiing std") 
            // {



            //     RunObject = Page progStagesTest;
            //     ApplicationArea = All;
            //     Visible = false;
            // }
            // action("Fin Test")
            // {



            //     RunObject = Page "Fin Test";
            //     ApplicationArea = All;
            //     Visible = false;
            // }
            // action(programIteration)
            // {
            //     Caption = 'Program Iterations';
            //     Image = FixedAssets;



            //     RunObject = Page "ACA-Programmes Iteration";
            //     ApplicationArea = All;
            // }
            action(unitsMater)
            {
                Caption = 'Units Master Table';
                Image = UserInterface;



                RunObject = Page "ACA-Units Master table";
                ApplicationArea = All;
            }
            action("Programme Leaders")
            {
                Image = FixedAssets;


                RunObject = page 79021;
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


            // action("Applications (Online)")
            // {
            //     Image = NewCustomer;
            //    
            //     
            //     RunObject = Page 68864;
            //     ApplicationArea = All;
            // }
            // action("Applications - Direct ")
            // {
            //     Image = NewCustomer;
            //    
            //     
            //     RunObject = Page 68848;
            //     ApplicationArea = All;
            // }
            action("Applicant Admission Letters")
            {
                Image = CustomerList;


                RunObject = Page 68515;
                ApplicationArea = All;
            }
            // action("Admissions (New)")
            // {
            //     Image = NewItem;
            //    
            //     
            //     RunObject = Page 68850;
            //     ApplicationArea = All;
            // }


            // action(Registration2)
            // {
            //     Image = Register;
            //    
            //    
            //     
            //     RunObject = Page 68836;
            //     ApplicationArea = All;
            // }
            // action("Students Card2")
            // {
            //     Image = Registered;
            //    
            //    
            //     
            //     RunObject = Page 68837;
            //     ApplicationArea = All;
            // }



        }
        area(sections)
        {
            group("Admissions")
            {
                Caption = 'Admissions';
                Image = RegisteredDocs;

                action(allApps)
                {
                    Caption = 'SRO';
                    RunObject = Page "ACA-Application Form H. list";
                    ApplicationArea = All;
                }
                action(process)
                {
                    Caption = 'My List';
                    RunObject = Page "SRO Processing";
                    ApplicationArea = All;

                }

                action(Applications)
                {
                    Caption = 'Departmental Admission Board';
                    RunObject = Page "DAB List";
                    ApplicationArea = All;
                }
                action(dabReject)
                {
                    Caption = 'DAB Rejected';
                    RunObject = Page "DAB Rejection List";
                    ApplicationArea = All;
                }

                action("Faculty Admission Board")
                {
                    ApplicationArea = All;
                    RunObject = Page "Applications FAB List";
                }
                action("Faculty Applications")
                {
                    ApplicationArea = All;
                    RunObject = Page "ACA-FAB Applications";
                    Visible = false;
                }
                action("Faculty Rejections")
                {
                    ApplicationArea = All;
                    RunObject = Page "FAB Rejection List";
                }
                action("UABC Admission Board")
                {
                    Caption = 'UAB Admission Board';
                    ApplicationArea = All;
                    RunObject = Page "Applications UABC List";
                }
                action("UAB Reject")
                {
                    Caption = 'UAB Reject';
                    ApplicationArea = All;
                    RunObject = Page "ACA-Rejected Applications List";
                }

                action("Issuance of Letter")
                {
                    ApplicationArea = All;
                    RunObject = Page "ACA- Admission Letters";
                    Visible = false;
                }
                action(Registrations)
                {
                    Caption = 'Registration';
                    RunObject = Page 70083;
                    Visible = true;
                    ApplicationArea = All;
                }
                action("Registration KUCCPS")
                {
                    RunObject = Page "ACA-KUCCPS Student Reg";
                    Visible = true;
                    ApplicationArea = All;
                }
                action("Admitted Students")
                {
                    Caption = 'Admitted Students';
                    RunObject = Page "ACA-Admitted Students";
                    ApplicationArea = All;
                }
                action("GSS Imports")
                {
                    Caption = 'Import GSS Admissions';
                    RunObject = Page 68491;
                    ApplicationArea = All;
                }
                // action(onlineUsers)
                // {
                //     Image = User;
                //     RunObject = page OnlineUsers;
                //     ApplicationArea = All;
                // }
            }
            group("Registration Process")
            {
                action("Units Offered")
                {
                    RunObject = Page "Units Offered Batches";
                    ApplicationArea = All;
                }
                action("Exam Timetable1")
                {
                    Caption = 'Exam Timetable';
                    RunObject = Page "ACA-Exam Units";
                    ApplicationArea = All;
                }
                action("Associate Units")
                {
                    RunObject = Page "ACA-Associated Units";
                    ApplicationArea = All;
                }
                action("PT Claim List")
                {
                    RunObject = Page "PT Claim batches";
                    ApplicationArea = All;
                }
            }
            // group("GSS Imports")
            // {

            // }
            // group("GSS Admission")
            // {
            //     //Caption = 'GSS Admission';
            //     // Image = Transactions;
            //     action("Import GSS Admissions")
            //     {
            //         Caption = 'Import GSS Admissions';
            //         RunObject = Page 68491;
            //         ApplicationArea = All;
            //     }

            //     /* action("Processed GSS Admissions")
            //     {
            //         Caption = 'Processed GSS Admissions';
            //         RunObject = Page 78132;
            //         Visible = false;
            //         ApplicationArea = All;
            //     }

            //     action("Admissions letters list")
            //     {
            //         Caption = 'Admissions letters list';
            //         RunObject = Page 68524;
            //         Visible = false;
            //         ApplicationArea = All;
            //     }
            //     action("pending documents verification")
            //     {
            //         Caption = 'pending documents verification';
            //         RunObject = Page 68483;
            //         ApplicationArea = All;
            //     }
            //     action("pending payments confirmation")
            //     {
            //         Caption = 'pending payments confirmation';
            //         RunObject = Page 68522;
            //         Visible = false;
            //         ApplicationArea = All;
            //     }
            //     action("pending Admission confirmation")
            //     {
            //         Caption = 'pending Admission confirmation';
            //         RunObject = Page 68523;
            //         Visible = false;
            //         ApplicationArea = All;
            //     }
            //     action(Admitted_GSS)
            //     {
            //         Caption = 'Admitted Students - GSS';
            //         RunObject = Page 70086;
            //         ApplicationArea = All;
            //     } */
            // }
            group("Students Management")
            {
                Caption = 'Students Management';
                Image = ResourcePlanning;
                action(Registration)
                {
                    Image = Register;



                    RunObject = Page 68836;
                    ApplicationArea = All;
                    Visible = False;
                }
                action("Students Card")
                {
                    Image = Registered;



                    RunObject = Page 68837;
                    ApplicationArea = All;
                }
                action(Programme)
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
            group("Master Rotation Plan")
            {
                Caption = 'Master Rotation Plan';
                Image = ResourcePlanning;
                action("Students on Session")
                {
                    Image = Allocate;
                    RunObject = Page "Student Session Registration";
                    ApplicationArea = All;
                }
                action("Rotation Areas")
                {
                    Image = Allocate;
                    RunObject = Page "Rotation Areas";
                    ApplicationArea = All;
                }
                action("Rotation Schedule")
                {
                    Image = Allocate;
                    RunObject = Page "Full Rotation Schedule";
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
            group("Part-Time Claims")
            {
                action("PT-Claims Pending Approval")
                {
                    RunObject = page "Parttime Claim List";
                    ApplicationArea = All;
                }
                action("Posted PT-claims")
                {
                    RunObject = page "Posted Parttime Claim List";
                    ApplicationArea = All;
                }
            }
            group(Timetabling)
            {
                Caption = 'Timetable Management';
                Image = Statistics;
                action(TimetableCentral)
                {
                    Caption = 'Teaching Timetable';
                    Image = Register;
                    RunObject = Page "TT-Timetable Batches";
                    ApplicationArea = All;
                }
                action("Exam Timetable")
                {
                    Caption = 'Exam Timetable';
                    RunObject = Page "EXT-Timetable Batches";
                    ApplicationArea = All;
                }
            }
            group("Lecture Evaluation")
            {
                action(Evaluation)
                {
                    ApplicationArea = All;


                    RunObject = page "ACA-Evaluation Semesters List";
                }
                action("Evaluation Results")
                {
                    ApplicationArea = All;
                    RunObject = page "Evaluation Results";
                }
            }
            group("Class Attendance")
            {
                action("Class Register")
                {
                    ApplicationArea = All;


                    RunObject = Page "Class Attendance List";
                }
            }
            group("Graduation Clearance")
            {
                action("Graduating Clearance List")
                {

                    ApplicationArea = All;
                    RunObject = Page "Graduation Clearance List";
                }
                action("Graduating Students2")
                {
                    Caption = 'Graduating Student';
                    ApplicationArea = All;


                    RunObject = Page "Graduation Card";
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
            group(thesis)
            {
                Caption = 'Project/Thesis Tracking';
                action(project)
                {
                    Caption = 'Thesis';
                    RunObject = Page "ACA-Project Thesis";
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
                action("Insurance Companies")
                {
                    Caption = 'Insurance Companies';
                    ApplicationArea = All;
                    //RunObject = Page 68844;
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
                    RunObject = Page 658;
                    ApplicationArea = All;
                }
                action("My Approval requests")
                {
                    Caption = 'My Approval requests';
                    RunObject = Page 662;
                    ApplicationArea = All;
                }
                action("Clearance Requests")
                {
                    Caption = 'Clearance Requests';
                    RunObject = Page 68970;
                    ApplicationArea = All;
                }
            }
            /* group(Common_req)
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
                    action("Class List")
                    {
                        Image = DueDate;
                        RunObject = Report 86524;
                        ApplicationArea = All;
                    }
                    action("Prog. Units")
                    {
                        Caption = 'PRogram Study Plan';
                        Image = Report;
                        RunObject = Report 51203;
                        ApplicationArea = All;
                    }
                    action(unitsOff)
                    {
                        Caption = 'Units On Offer';
                        Image = Report;
                        RunObject = Report 86522;
                        ApplicationArea = All;
                    }
                    action("Student Applications Report")
                    {
                        Caption = 'Student Applications Report';
                        Image = Report;
                        RunObject = Report 51862;
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

                    action("Enrollment By Stage")
                    {
                        Caption = 'Enrollment By Stage';
                        Image = Report2;
                        RunObject = Report 51545;
                        ApplicationArea = All;
                    }
                    action("Import Units")
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
                        Image = Agreement;

                        RunObject = Report 63905;
                        ApplicationArea = All;
                    }
                }
                group("Before Exams")
                {
                    Caption = 'Before Exams';
                    action("Examination Cards")
                    {
                        Caption = 'Examination Cards';
                        Image = Card;


                        RunObject = Report 51774;
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
                group("Students Finance Reports")
                {
                    Image = Statistics;
                    action("Validate Settlement")
                    {
                        Image = PrintInstallment;
                        RunObject = Report "Validate Settlement Type";
                        ApplicationArea = All;
                    }

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
            }
        }


    }
}

