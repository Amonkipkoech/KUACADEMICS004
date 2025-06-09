page 40070 "Student Duty Rotas List"
{
    PageType = List;
    SourceTable = "Student Rota Header";
    Caption = 'All Duty Rotas';
    Editable = false;
    CardPageId = "Student Rota Header Card";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("ID"; rec."ID") { }
                field("Semester"; rec."Semester") { }
                field("Academic Year"; rec."Academic Year") { }
                field("Status"; rec."Status") { }
                field("Current"; rec."Current") { }
            }
        }
    }
}
