page 40069 "Student Rota Line Subpage"
{
    PageType = ListPart;
    SourceTable = "Student Rota Line";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Student Name"; "Student Name") { }
                field("Institution"; Institution) { }
                field("Program"; Program) { }
                field("Ward"; Ward) { }
                field("Date"; Date) { }
                field("Shift Code"; "Shift Code") { }
                field("Viewable"; "Viewable") { Editable = false; }
            }
        }
    }
}

