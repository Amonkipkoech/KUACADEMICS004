page 40064 "Institution Request Line Part"
{

    PageType = ListPart;
    SourceTable = "Institution Request Line";


    layout
    {
        area(Content)
        {
            repeater(Lines)
            {
                field("Student Number"; "Student Number") { }
                field("Student Name"; "Student Name") { }
                field("Phone Number"; "Phone Number") { }
                field("School Email"; "School Email") { }
            }
        }
    }
}
