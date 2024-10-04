report 51345 "Provisional Admission Letter"
{

    ApplicationArea = All;
    RDLCLayout = './Reports/SSR/provisionalAdmissionLetter.rdl';
    PreviewMode = PrintLayout;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem(bAdmLetter; "ACA-Applic. Form Header")
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
            column(Application_Date; format("Application Date"))
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
            column(fee; format(fee))
            {

            }
            column(Intake_Code; "Intake Code")
            {

            }
            column(ReportingDate; format(ReportingDate))
            {

            }
            column(Date_of_Admission; format("Date of Admission"))
            {

            }
            column(name; CompanyInformation.Name)
            {

            }
            column(faculty; faculty)
            {

            }
            column(Settlement_Type; "Settlement Type")
            {

            }
            column(EndDateText; EndDateText)
            {

            }
            column(appDate; appDate)
            {

            }
            column(Campus; Campus)
            {

            }
            column(campusText; campusText)
            {

            }
            column(letterHead; letterHead)
            {

            }
            column(letterHead2; letterHead2)
            {

            }
            column(letterHead3; letterHead3)
            {

            }
            column(letterHead4; letterHead4)
            {

            }
            column(footer1; footer1)
            {

            }
            column(footer2; footer2)
            {

            }
            column(footer3; footer3)
            {

            }
            column(Provisional_Admision_Reason; "Provisional Admision Reason")
            {

            }
            column(provisionalAdmission; provisionalAdmission)
            {

            }

            trigger OnAfterGetRecord()
            begin
                if bAdmLetter."Application Type" = bAdmLetter."Application Type"::Full then
                    letterHead := Header1;
                //else
                //     if bAdmLetter."Application Type" = bAdmLetter."Application Type"::Provisional then
                //         letterHead := Header2;
                // letterHead2 := Header3;
                // letterHead3 := Header4;
                // letterHead4 := provisionalAdmission;
                // footer1 := footer;
                // footer3 := Header6;

                progFee.Reset();
                progFee.SetRange(progFee.ProgCode, bAdmLetter."First Degree Choice");
                progFee.SetRange(progFee.ModeOfstudy, bAdmLetter."Settlement Type");
                progFee.SetRange(progFee.Campus, bAdmLetter.Campus);
                if progFee.Find('-') then begin
                    fee := progFee.intakeFee;
                end
                else
                    Error('No Fee Defined on Intake Setup');
                prog.reset();
                prog.SetRange(prog.Code, bAdmLetter."First Degree Choice");
                if prog.find('-') then begin
                    faculty := prog."Faculty Name";
                end
                else
                    error('Program Faculty Name Not Defined');
                Intake.Reset();
                Intake.SetRange(Intake."Code", bAdmLetter."Intake Code");
                Intake.SetRange(Intake.Level, bAdmLetter."Programme Level");
                if Intake.Find('-') then begin
                    ReportingDate := Intake."Reporting Date";
                    EndDateText := format(ReportingDate, 0, 4);
                    appDate := Format("Application Date", 0, 4);
                end
                else
                    Error('No Date Defined on Intake Setup');
                if Campus = 'LANGATA' then
                    campusText := langatatext
                else
                    campusText := gabatext;
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
        prog: Record "ACA-Programme";
        faculty: text[200];
        Dimn: Record "Dimension Value";
        EndDateText: Text;
        appDate: Text;
        gabatext: Label 'Main Hall - Gaba Campus';
        langatatext: Label 'Learning Resource Center - Langata Campus';
        provisionalAdmission: Label 'Kindly note that this provisional admission is valid for one academic year subject to fullfilling the above condition.  Note that if the condition is not met the admission will stand revoked.';
        footer: Label 'If you are in agreement with the above statement kindly sign below.';
        Header1: Label 'ADMISSION';
        Header2: Label 'PROVISIONAL ADMISSION';
        Header3: Label 'provisionally';
        Header4: Label 'pending';
        Header5: Label 'an admission';
        Header6: Label 'a Provisional admission';
        campusText: text[200];
        letterHead: Text;
        letterHead2: Text;
        letterHead3: Text;
        letterHead4: Text;
        footer1: Text;
        footer2: Text;
        footer3: Text;

    // trigger OnPreReport()
    // begin

    // end;




}