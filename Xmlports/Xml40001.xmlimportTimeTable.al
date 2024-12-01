xmlport 40001 xmlimportTimeTable

{
    Direction = Import;
    Format = VariableText;
    DefaultFieldsValidation = false;
    UseRequestPage = true;

    schema
    {
        textelement(root)
        {
            tableelement(UnitsOffered; "ACA-Units Offered")
            {
                fieldelement(Programs; UnitsOffered.Programs)
                {
                }
                fieldelement(ProgramName; UnitsOffered."Program Name")
                {
                }
                fieldelement(UnitBaseCode; UnitsOffered."Unit Base Code")
                {
                }
                fieldelement(Department; UnitsOffered.Department)
                {
                }
                fieldelement(Day; UnitsOffered.Day)
                {
                }
                fieldelement(TimeSlot; UnitsOffered.TimeSlot)
                {
                }
                fieldelement(Semester; UnitsOffered.Semester)
                {
                }
                fieldelement(LectureHall; UnitsOffered."Lecture Hall")
                {
                }
                fieldelement(AcademicYear; UnitsOffered."Academic Year")
                {
                }
                fieldelement(Lecturer; UnitsOffered.Lecturer)
                {
                }
                fieldelement(ModeofStudy; UnitsOffered.ModeofStudy)
                {
                }
                fieldelement(Stream; UnitsOffered.Stream)
                {
                }
                fieldelement(Campus; UnitsOffered.Campus)
                {
                }
                fieldelement(FinalExamDate; UnitsOffered."Final Exam Date")
                {
                }
                fieldelement(FinalExamDay; UnitsOffered."final exam day")
                {
                }
                fieldelement(FinalExamTime; UnitsOffered."final Exam Time")
                {
                }
                fieldelement(FinalExamRoom; UnitsOffered."Final Exam Room")
                {
                }
                fieldelement(Invigilator1; UnitsOffered."Invigilator 1")
                {
                }
                fieldelement(Invigilator2; UnitsOffered."Invigilator 2")
                {
                }
                fieldelement(Invigilator3; UnitsOffered."Invigilator 3")
                {
                }
            }
        }
    }



}
