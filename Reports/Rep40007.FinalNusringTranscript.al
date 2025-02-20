report 40007 "FinalNusring Transcript"
{
    Caption = 'FinalNusring Transcript';
    DefaultLayout = RDLC;
    RDLCLayout = './Reports/SSR/NursingTranscrip.rdl';

    dataset
    {
        dataitem("Semester Registration"; "ACA-Course Registration")
        {
            RequestFilterFields = "Student No.", "Academic Year", Semester;
            column(StudNCsReg; "Student No.")
            {
            }
            column(Student_NameCReg; "Student Name")
            {
            }
            column(ProgrammesCsReg; Programmes)
            {
            }
            column(Academic_YearCsReg; "Academic Year")
            {
            }
            column(StageCsReg; Stage)
            {
            }
            column(SemesterCsReg; Semester)
            {
            }
            column(infoName; info.Name)
            {
            }
            column(infoAddress; info.Address)
            {
            }
            column(infoAddress2; info."Address 2")
            {
            }
            column(infoCity; info.City)
            {
            }
            column(infoEmail; info."E-Mail")
            {
            }
            column(infoPhone; info."Phone No.")
            {
            }




            dataitem(StudUnitsss2; "ACA-Student Theory Units ")
            {
                DataItemLink = "Student No." = FIELD("Student No.");
                column(UnitTheory; unit)
                {
                }
                column(DescTheory; "Unit Description")
                {
                }
                column(CreditHoursTheory; "Credit Hours")
                {
                }
                column(ProgrammeTheory; Programme)
                {
                }
                column(Academic_Year_Theory; "Academic Year")
                {
                }
                column(Unit_Stage_Theory; "Unit Stage")
                {

                }

            }
            dataitem("ACA-Student Units"; "ACA-Student Units")
            {
                DataItemLink = "Student No." = field("Student No.");
                column(Student_No_Exam; "Student No.")
                {

                }
                column(SemesterExam; Semester)
                {

                }
                column(ProgrammeExam; Programme)
                {

                }
                column(UnitExam; Unit)
                {

                }
                column(DescriptionExam; Description)
                {

                }
                column(Unit_DescriptionExam; "Unit Description")
                {

                }
                column(Academic_YearExam; "Academic Year")
                {

                }
                column(Credit_HoursExam; "Credit Hours")
                {

                }


            }
            dataitem(CompanyInformation2; "Company Information")
            {
                column(Picture2; Picture)
                {

                }
            }

        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }
    trigger OnPreReport()
    var
        myInt: Integer;
    begin

        CompanyInformation2.CalcFields(Picture)
    end;

    var
        info: Record "Company Information";
        CompanyInformation: Record 79;
}
