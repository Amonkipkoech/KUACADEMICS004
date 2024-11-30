xmlport 86619 "Import Units Offered"
{
    Direction = Import;
    Format = Xml;
    UseRequestPage = true;

    schema
    {
        // Define the root text element
        textelement(root)
        {
            // Define the table element for ACA-UnitsOffered
            tableelement("ACA-UnitsOffered"; "ACA-Units Offered")
            {
                // Map fields to XML elements using fieldelement
                fieldelement(Programs; "ACA-UnitsOffered".Programs)
                {
                }
                fieldelement("Unit_Base_Code"; "ACA-UnitsOffered"."Unit Base Code")
                {
                }
                fieldelement(Day; "ACA-UnitsOffered".Day)
                {
                }
                fieldelement(TimeSlot; "ACA-UnitsOffered".TimeSlot)
                {
                }
                fieldelement(Semester; "ACA-UnitsOffered".Semester)
                {
                }
                fieldelement("Lecture_Hall"; "ACA-UnitsOffered"."Lecture Hall")
                {
                }
                fieldelement(Lecturer; "ACA-UnitsOffered".Lecturer)
                {
                }
                fieldelement(ModeofStudy; "ACA-UnitsOffered".ModeofStudy)
                {
                }
                fieldelement(Stream; "ACA-UnitsOffered".Stream)
                {
                }
                fieldelement(Campus; "ACA-UnitsOffered".Campus)
                {
                }
            }
            
        }
        
    }

    
}
