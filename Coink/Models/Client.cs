namespace Coink.Models
{
    public class ClientModel
    {
        public required string FirstName { get; set; }
        public required string LastName { get; set; }
        public required string Address { get; set; }
        public long PhoneNumber { get; set; }
        public int City_id { get; set; }
    }

    public class ClientView
    {
        public required string FirstName { get; set; }
        public required string LastName { get; set; }
        public required string Address { get; set; }
        public long PhoneNumber { get; set; }
        public required string City_name { get; set; }
        public required string State_name { get; set; }
        public required string Country_name { get; set; }
    }
}
