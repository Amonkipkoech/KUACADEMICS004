/// <summary>
/// Page ACA-Online Application Req. (ID 68862).
/// </summary>
page 68862 "ACA-Online Application Req."
{
    PageType = Card;
    SourceTable = "ACA-Online Application";
    SourceTableView = WHERE(Status = FILTER(New));

    layout
    {
        area(content)
        {
            group("Application Request")
            {
                field("Applicant Id Number"; Rec."Applicant Id Number")
                {
                    ApplicationArea = All;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                }
                field(Title; Rec.Title)
                {
                    ApplicationArea = All;
                }
                field(Surname; Rec.Surname)
                {
                    ApplicationArea = All;
                }
                field("Other Names"; Rec."Other Names")
                {
                    ApplicationArea = All;
                }
                field(Gender; Rec.Gender)
                {
                    ApplicationArea = All;
                }
                field("National ID"; Rec."National ID")
                {
                    ApplicationArea = All;
                }
                field(box; Rec.box)
                {
                    Caption = 'P.O. Box';
                    ApplicationArea = All;
                }
                field(TelNo_1; Rec.TelNo_1)
                {
                    Caption = 'Telephone';
                    ApplicationArea = All;
                }
                field(TelNo_2; Rec.TelNo_2)
                {
                    Caption = 'Cell Phone';
                    ApplicationArea = All;
                }
                field(email; Rec.email)
                {
                    Caption = 'E-Mail';
                    ApplicationArea = All;
                }
                field(County; Rec.County)
                {
                    ApplicationArea = All;
                }
                field(Level; Rec.Level)
                {
                    Caption = 'Programme Category';
                    ApplicationArea = All;
                }
                field(Programe_Code1; Rec.Programe_Code1)
                {
                    Caption = 'Program (Option 1)';
                    ApplicationArea = All;
                }
                field("Prog. Entry level"; Rec."Prog. Entry level")
                {
                    ApplicationArea = All;
                }
                field("Study Mode"; Rec."Study Mode")
                {
                    ApplicationArea = All;
                }
                field("Receipt Number"; Rec."Receipt Number")
                {
                    ApplicationArea = All;
                }
                field("Receipt Date"; Rec."Receipt Date")
                {
                    ApplicationArea = All;
                }
                field(Nationality; Rec.Nationality)
                {
                    ApplicationArea = All;
                }
                field(Town; Rec.Town)
                {
                    ApplicationArea = All;
                }
                field(Programe_Code2; Rec.Programe_Code2)
                {
                    Caption = 'Program (Option 2)';
                    ApplicationArea = All;
                }
                field(Intake; Rec.Intake)
                {
                    ApplicationArea = All;
                }
                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = All;
                }
                field("Sponsor Name"; Rec."Sponsor Name")
                {
                    ApplicationArea = All;
                }
                field("Health Insured"; Rec."Health Insured")
                {
                    ApplicationArea = All;
                }
                field("Insurer Name"; Rec."Insurer Name")
                {
                    ApplicationArea = All;
                }
                field("Marketing Strategy"; Rec."Marketing Strategy")
                {
                    Caption = 'How you knew the College';
                    ApplicationArea = All;
                }
                field("Knew us through (Name)"; Rec."Knew us through (Name)")
                {
                    ApplicationArea = All;
                }
                field("Other Marketing (Specify)"; Rec."Other Marketing (Specify)")
                {
                    Caption = 'How you knew us - Others (Specify)';
                    ApplicationArea = All;
                }
                field("Approval Comments"; Rec."Approval Comments")
                {
                    ApplicationArea = All;
                }
            }
            group(Emergency_Contacts)
            {
                Caption = 'Emergency Contacts';
                field("Emergency Contact Name"; Rec."Emergency Contact Name")
                {
                    ApplicationArea = All;
                }
                field("Emergency Contact Tel"; Rec."Emergency Contact Tel")
                {
                    ApplicationArea = All;
                }
                field("Emergency Phone"; Rec."Emergency Phone")
                {
                    ApplicationArea = All;
                }
                field("Emergency Contact Email"; Rec."Emergency Contact Email")
                {
                    ApplicationArea = All;
                }
                field("Emergency Contact Fax"; Rec."Emergency Contact Fax")
                {
                    ApplicationArea = All;
                }
                field("Emergency Contact Relationship"; Rec."Emergency Contact Relationship")
                {
                    ApplicationArea = All;
                }
            }
            group(Education)
            {
                field("Highest Institution/University"; Rec."Highest Institution/University")
                {
                    ApplicationArea = All;
                }
                field("Highest Qualification"; Rec."Highest Qualification")
                {
                    ApplicationArea = All;
                }
            }
            group(EnglishLanguage)
            {
                Caption = 'English language';
                field("Language (1)"; Rec."Language (1)")
                {
                    ApplicationArea = All;
                }
                field("Language (2)"; Rec."Language (2)")
                {
                    ApplicationArea = All;
                }
            }
            group(Declaration)
            {
                Caption = 'To The Best of my knowledge, The information in True';
                field("Declaration Name"; Rec."Declaration Name")
                {
                    ApplicationArea = All;
                }
                field("Declaration Date"; Rec."Declaration Date")
                {
                    ApplicationArea = All;
                }
            }
            group(Employment_History)
            {
                Caption = 'Employment History';
                field("Present Employer (Name)"; Rec."Present Employer (Name)")
                {
                    ApplicationArea = All;
                }
                field("Present Employer (Address)"; Rec."Present Employer (Address)")
                {
                    ApplicationArea = All;
                }
                field("Present Employer (Telephone)"; Rec."Present Employer (Telephone)")
                {
                    ApplicationArea = All;
                }
                field("Present Employer (Position)"; Rec."Present Employer (Position)")
                {
                    ApplicationArea = All;
                }
                field("Present Employer (Email)"; Rec."Present Employer (Email)")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        // area(navigation)
        // {
        //     Description = 'Approval of Online Applications';
        //     action("PhD Requirements")
        //     {
        //         Image = Questionaire;
        //         Promoted = true;
        //         RunObject = Page 50015;
        //         RunPageLink = Field1 = FIELD("Applicant Id Number");
        //     }
        //     action(Institutions)
        //     {
        //         Image = CompanyInformation;
        //         Promoted = true;
        //         RunObject = Page 50016;
        //         RunPageLink = Field1 = FIELD("Applicant Id Number");
        //     }
        //     action("Prof. Qualification")
        //     {
        //         Image = QualificationOverview;
        //         Promoted = true;
        //         RunObject = Page 50017;
        //         RunPageLink = Field1 = FIELD("Applicant Id Number");
        //     }
        //     action("Research Work")
        //     {
        //         Image = MarketingSetup;
        //         Promoted = true;
        //         RunObject = Page 50018;
        //         RunPageLink = Field1 = FIELD("Applicant Id Number");
        //     }
        //     action(References)
        //     {
        //         Image = CustomerContact;
        //         Promoted = true;
        //         RunObject = Page 50019;
        //         RunPageLink = Field1 = FIELD("Applicant Id Number");
        //     }
        //     action("Send Approval Request")
        //     {
        //         Image = SendApprovalRequest;
        //         Promoted = true;
        //         PromotedCategory = Process;

        //         trigger OnAction()
        //         var
        //             ApprovalMgt: Codeunit "439";
        //         begin

        //             IF Rec."Applicant Id Number" = '' THEN
        //                 ERROR('No Applicants selected for Approval');
        //             //Release the Application for Approval
        //             IF AppSetup.GET() THEN
        //                 IF (TODAY - Rec."Date of Birth") < (AppcSetup."Minimum Age" * 365) THEN ERROR('The Minimum Required Age for Admission is ' + FORMAT(AppcSetup."Minimum Age") + ' years');

        //             IF CONFIRM('Send this Application for Approval?', TRUE) = FALSE THEN EXIT;

        //             //Apps.RESET;
        //             //Apps.SETRANGE(Apps."Application No.","Application No.");
        //             //Testfields;
        //             IF Rec."Application Date" = 0D THEN
        //                 ERROR('Provide the Application Date First!');
        //             //IF "Application Form Receipt No."='' THEN
        //             // ERROR('Provide the Bank Slip number.');
        //             //WITH Apps DO
        //             //   BEGIN
        //             // "User ID":=USERID;
        //             //  "Date of Receipt":=TODAY;
        //             // MODIFY;
        //             //END;
        //             // ERROR('Niko');
        //             // Status:=Status::Approved;
        //             // VALIDATE(Status);
        //             //MESSAGE('Application Request has been automatically approved and released.');
        //             //IF ApprovalMgt.SendOnlineApplicationApprovals(Rec) THEN BEGIN
        //             //MESSAGE(FORMAT(xRec.Surname)+' successfully send for Approval');
        //             //CurrPage.UPDATE;
        //             //END;





        //             /*










        //           applicformHead.INIT;
        //           applicformHead."ID Number":="Applicant Id Number";
        //           applicformHead.Surname:=Surname;
        //           applicformHead."Other Names":="Other Names";
        //           applicformHead."Programme Level":=Level;
        //           applicformHead.Nationality:=Nationality;
        //           applicformHead."First Degree Choice":=Programe_Code1;
        //           applicformHead."Second Degree Choice":=Programe_Code2;
        //           applicformHead."Application Date":="Application Date";
        //           applicformHead."Telephone No. 1":=TelNo_1;
        //           applicformHead."Telephone No. 2":=TelNo_2;
        //           applicformHead."Address for Correspondence3":=email;
        //           applicformHead."Receipt Slip No.":=BankSlipNo;
        //           applicformHead."Date Of Receipt Slip":=BankSlipDate;
        //           applicformHead.Gender:=Gender;
        //           applicformHead."Address for Correspondence1":=box+'-'+code;
        //           applicformHead."Address for Correspondence2":=Town;
        //           applicformHead.District:=County;
        //           applicformHead."First Choice Semester":=Intake;
        //           applicformHead.Password:="Applicant Id Number";
        //           applicformHead.INSERT(TRUE);

        //           Status:=Status::"Pending Approval";
        //           MODIFY;
        //           // Notify Applicant
        //           MESSAGE('Application request Accepted.');
        //             {
        //           // Send Email to the Applicant Nitifying them of the Approvals

        //           Subject := STRSUBSTNO('ILU Admission Application','Approved Request');
        //           Body := 'Your Request for application at ILU has been Approved!';

        //           ////SMTP.CreateMessage(SenderName,SenderAddress,Recipient,Subject,Body,TRUE);
        //           //Body := '';

        //           WHILE InStreamTemplate.EOS() = FALSE DO BEGIN
        //             InStreamTemplate.READTEXT(InSReadChar,1);
        //             IF InSReadChar = '%' THEN BEGIN
        //               //SMTP.AppendBody(Body);
        //               Body := InSReadChar;
        //               IF InStreamTemplate.READTEXT(InSReadChar,1) <> 0 THEN;
        //               IF (InSReadChar >= '0') AND (InSReadChar <= '9') THEN BEGIN
        //                 Body := Body + '1';
        //                 CharNo := InSReadChar;
        //                 WHILE (InSReadChar >= '0') AND (InSReadChar <= '9') DO BEGIN
        //                   IF InStreamTemplate.READTEXT(InSReadChar,1) <> 0 THEN;
        //                   IF (InSReadChar >= '0') AND (InSReadChar <= '9') THEN
        //                     CharNo := CharNo + InSReadChar;
        //                 END;
        //               END ELSE
        //                 Body := Body + InSReadChar;
        //             //  FillSalesTemplate(Body,CharNo,SalesHeader,ApprovalEntry,0);
        //               //SMTP.AppendBody(Body);
        //               Body := InSReadChar;
        //             END ELSE BEGIN
        //               Body := Body + InSReadChar;
        //               I := I + 1;
        //               IF I = 500 THEN BEGIN
        //                 //SMTP.AppendBody(Body);
        //                 Body := '';
        //                 I := 0;
        //               END;
        //             END;
        //           END;
        //           //SMTP.AppendBody(Body);
        //           //SMTP.Send;
        //            }

        //           CurrPage.UPDATE;
        //              */

        //         end;
        //     }
        // }
    }

    var
        applicformHead: Record "ACA-Applic. Form Header";
        //  AppSetup: Record 452;
        //SMTP: Codeunit 400;
        SenderName: Text[100];
        SenderAddress: Text[100];
        Recipient: Text[100];
        Subject: Text[100];
        Body: Text[1024];
        InStreamTemplate: InStream;
        InSReadChar: Text[1];
        CharNo: Text[4];
        I: Integer;
        FromUser: Text[100];
        MailCreated: Boolean;
        DegreeName1: Text[200];
        DegreeName2: Text[200];
        FacultyName1: Text[200];
        FacultyName2: Text[200];
        NationalityName: Text[200];
        CountryOfOriginName: Text[200];
        Age: Text[200];
        FormerSchoolName: Text[200];
        CustEntry: Record "Cust. Ledger Entry";
        Apps: Record "ACA-Applic. Form Header";
        recProgramme: Record "ACA-Programme";
        FirstChoiceSemesterName: Text[200];
        FirstChoiceStageName: Text[200];
        SecondChoiceSemesterName: Text[200];
        SecondChoiceStageName: Text[200];
        [InDataSet]
        "Principal PassesVisible": Boolean;
        [InDataSet]
        "Subsidiary PassesVisible": Boolean;
        [InDataSet]
        "Mean Grade AcquiredVisible": Boolean;
        [InDataSet]
        "Points AcquiredVisible": Boolean;
        UserMgt: Codeunit 50114;
        Doc_Type: Option LPO,Requisition,Imprest,"Payment Voucher";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,Admission;
        ApprovalEntries: Page "Approval Entries";
        AppcSetup: Record "ACA-Applic. Setup";
        //AdmissionsQualif: Codeunit "Admissions Qualifations";
        EnqH: Record "ACA-Enquiry Header";
}

