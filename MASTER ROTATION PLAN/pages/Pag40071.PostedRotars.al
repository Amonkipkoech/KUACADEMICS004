page 40071 "Posted Rotas View"
{
    PageType = List;
    SourceTable = "Student Rota Line";
    Caption = 'All Posted Rotas';
    Editable = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Header ID"; "Header ID") { }
                field("Student Name"; "Student Name") { }
                field("Ward"; "Ward") { }
                field("Date"; "Date") { }
                field("Shift Code"; "Shift Code") { }
                field("Viewable"; "Viewable") { }
            }
        }
    }
}
