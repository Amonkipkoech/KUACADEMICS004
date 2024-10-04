/// <summary>
/// Page ACA-Approved Online Applics (ID 68833).
/// </summary>
page 68833 "ACA-Approved Online Applics"
{
    PageType = Card;
    SourceTable = 61647;
    SourceTableView = WHERE(Status = FILTER(Approved));

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
                field(BankSlipNo; Rec.BankSlipNo)
                {
                    ApplicationArea = All;
                }
                field(BankSlipDate; Rec.BankSlipDate)
                {
                    ApplicationArea = All;
                }
                field(Nationality; Rec.Nationality)
                {
                    ApplicationArea = All;
                }
                field(code; Rec.code)
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
                field(BankSlipImage; Rec.BankSlipImage)
                {
                    Caption = 'Result Slip Scan';
                    ApplicationArea = All;
                }
                field("Marketing Strategy"; Rec."Marketing Strategy")
                {
                    Caption = 'How you knew the College';
                    ApplicationArea = All;
                }
                field("Other Marketing (Specify)"; Rec."Other Marketing (Specify)")
                {
                    Caption = 'How you knew us - Others (Specify)';
                    ApplicationArea = All;
                }
            }
        }
        area(factboxes)
        {
            systempart(notes; Notes)
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
    }

    var
        applicformHead: Record "ACA-Applic. Form Header";
        // AppSetup: Record 452;
#pragma warning disable AL0432
        //SMTP: Codeunit "SMTP Mail";
#pragma warning restore AL0432
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

        Doc_Type: Option LPO,Requisition,Imprest,"Payment Voucher";
        DocumentType: Option Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order","None","Payment Voucher","Petty Cash",Imprest,Requisition,Admission;

        AppcSetup: Record "ACA-Applic. Setup";
    //AdmissionsQualif: Codeunit "50140";
    //EnqH: Record "61348";
}

