report 86663 "Applicant Summary"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = './Reports/SSR/acaAplicantSummary.rdl';
    PreviewMode = PrintLayout;

    dataset
    {

        dataitem(DataItemName; "ACA-Applic. Form Header")
        {
            RequestFilterFields = "Application No.";
            column(Pic; CompanyInformation.Picture)
            {

            }
            column(Name; CompanyInformation.Name)
            {

            }
            column(Application_No_;"Application No.")
            {

            }
            column(FirstName_DataItemName; "First Name")
            {
            }
            column(OtherNames_DataItemName; "Other Names")
            {
            }
            column(Surname_DataItemName; Surname)
            {
            }
            column(Gender_DataItemName; Gender)
            {
            }
            column(DateOfBirth_DataItemName; "Date Of Birth")
            {
            }
            column(Nationality_DataItemName; Nationality)
            {
            }
            column(County_DataItemName; County)
            {
            }
            column(IDNumber_DataItemName; "ID Number")
            {
            }
            column(PassportNumber_DataItemName; "Passport Number")
            {
            }
            column(BirthCertNo_DataItemName; "Birth Cert No")
            {
            }
            column(Religion_DataItemName; Religion)
            {
            }
            column(Denomination_DataItemName; Denomination)
            {
            }
            column(Congregation_DataItemName; Congregation)
            {
            }
            column(Diocese_DataItemName; Diocese)
            {
            }
            column(MaritalStatus_DataItemName; "Marital Status")
            {
            }
            column(Disability_DataItemName; Disability)
            {
            }
            column(NatureofDisability_DataItemName; "Nature of Disability")
            {
            }
            column(PreviousEducationLevel_DataItemName; "Previous Education Level")
            {
            }
            column(Telephone_No__1; "Telephone No. 1")
            {

            }
            column(Telephone_No__2; "Telephone No. 2")
            {

            }
            column(Email; Email)
            {

            }
            column(Programme_Level; "Programme Level")
            {

            }
            column(Intake_Code; "Intake Code")
            {

            }
            column(First_Degree_Choice; "First Degree Choice")
            {

            }
            column(programName; programName)
            {

            }
            column(Programme_Faculty; "Programme Faculty")
            {

            }
            column(Mode_of_Study; "Mode of Study")
            {

            }
            column(Campus; Campus)
            {

            }
            column(First_Choice_Semester; "First Choice Semester")
            {

            }
            column(Index_Number;"Index Number")
            {

            }
            column(formerSchool;formerSchool)
            {

            }
            column(Date_of_Admission;"Date of Admission")
            {

            }
            column(Date_of_Completion;"Date of Completion")
            {

            }
            column(Year_of_Examination;"Year of Examination")
            {

            }
            column(Examination_Body;"Examination Body")
            {

            }
            column(Examination;Examination)
            {

            }
            column(Mean_Grade_Acquired;"Mean Grade Acquired")
            {

            }
            column(College_UNV_attended;"College/UNV attended")
            {

            }
            column(College_Unv_attend_start_date;"College/Unv attend start date")
            {

            }
            column(College_Unv_attend_final_date;"College/Unv attend final date")
            {

            }

        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {

            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }


    trigger OnInitReport()
    begin
        CompanyInformation.RESET;
        IF CompanyInformation.FIND('-') THEN BEGIN
            CompanyInformation.CALCFIELDS(Picture);
        END;
    end;

    var
        myInt: Integer;
        CompanyInformation: Record 79;
}