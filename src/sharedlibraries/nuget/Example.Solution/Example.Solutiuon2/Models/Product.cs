using System;
namespace Example.Solutiuon2.Models
{
    public class Product
    {
        public string Id { get; set; }

        public Product()
        {
            Id = Guid.NewGuid().ToString();
        }
    }
}

