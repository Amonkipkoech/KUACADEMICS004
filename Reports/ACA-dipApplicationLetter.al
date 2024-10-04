report 66681 "Diploma Admission Letter"
{

    ApplicationArea = All;
    RDLCLayout = './Reports/SSR/dipAdmissionLetter.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(dipLetter; "ACA-Applic. Form Header")
        {
            column(Admission_No; "Admission No")
            {

            }
            column(Application_No_; "Application No.")
            {

            }
            column(programName; programName)
            {

            }
            column(Programme_Faculty; "Programme Faculty")
            {

            }
            column(Faculty_Name; "Faculty Name")
            {

            }
            column(Application_Date; "Application Date")
            {

            }
            column(Other_Names; "Other Names")
            {

            }
            column(First_Name; "First Name")
            {

            }
            column(Surname; Surname)
            {

            }
            column(First_Degree_Choice; "First Degree Choice")
            {

            }
            column(CompanyInformation; CompanyInformation.Picture)
            {

            }
            column(Fee_payable; "Fee payable")
            {

            }
            column(Reporting_date; "Reporting date")
            {

            }
            column(fee; fee)
            {

            }
            column(Intake_Code; "Intake Code")
            {

            }
            column(ReportingDate; ReportingDate)
            {

            }
            trigger OnAfterGetRecord()
            begin
                progFee.Reset();
                progFee.SetRange(progFee.ProgCode, dipLetter."First Degree Choice");
                if progFee.Find('-') then begin
                    fee := progFee.intakeFee;
                end;
                Intake.Reset();
                Intake.SetRange(Intake."Code", dipLetter."Intake Code");
                if Intake.Find('-') then begin
                    ReportingDate := Intake."Reporting Date";
                end;
            end;



        }
    }

    requestpage
    {
        layout
        {

        }

        actions
        {

        }
    }

    trigger OnInitReport()
    begin

        if CompanyInformation.Get() then begin
            CompanyInformation.CalcFields(CompanyInformation.Picture);
        end;


    end;

    var
        CompanyInformation: Record "Company Information";
        progFee: Record "ACA-ProgramIntakeFee";
        fee: Decimal;
        Intake: Record "ACA-Intake";
        ReportingDate: Date;


}