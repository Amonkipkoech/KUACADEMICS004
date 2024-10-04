page 84517 "importMarksBuffer"
{

    PageType = List;
    SourceTable = "Import Marks Buffer";
    //DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field(examEntry; Rec.examEntry)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the examEntry field.';
                }
                field(studentNo; Rec.studentNo)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the studentNo field.';
                }
                field(AcademicYr; Rec.AcademicYr)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the AcademicYr field.';
                }
                field(Sem; Rec.Sem)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Sem field.';
                }
                field(unitCode; Rec.unitCode)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the unitCode field.';
                }
                field(uniName; Rec.uniName)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the uniName field.';
                }
                field(Prog; Rec.Prog)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Prog field.';
                }
                field(cat; Rec.cat)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the cat field.';
                }
                field(Exam; Rec.Exam)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Exam field.';
                }
                field(Exists; Rec.Exists)
                {
                    ApplicationArea = All;
                }

            }
        }


    }
    actions
    {
        area(Creation)
        {
            action(import)
            {
                Image = ViewCheck;
                Promoted = true;
                ApplicationArea = All;
                RunObject = xmlport "Import Buffer marks2";



            }

        }

    }
}