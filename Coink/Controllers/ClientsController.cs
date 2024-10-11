using Coink.Models;
using Microsoft.AspNetCore.Mvc;
using Npgsql;

namespace Coink.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class ClientController : ControllerBase
    {
        private readonly IConfiguration _configuration;

        public ClientController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        [HttpGet]
        public IActionResult GetClients()
        {
            string connectionString = _configuration.GetConnectionString("PostgresConnection");

            using (var connection = new NpgsqlConnection(connectionString))
            {
                connection.Open();

                string query = "SELECT * FROM \"Main\".\"get_all_clients\"()";

                using (var command = new NpgsqlCommand(query, connection))
                {
                    using (var reader = command.ExecuteReader())
                    {
                        var clients = new List<Dictionary<string, object>>();
                        while (reader.Read())
                        {
                            var client = new Dictionary<string, object>();
                            for (int i = 0; i < reader.FieldCount; i++)
                            {
                                client[reader.GetName(i)] = reader.GetValue(i);
                            }
                            clients.Add(client);
                        }
                        return Ok(clients);
                    }
                }
            }
        }

        [HttpGet("{id}")]
        public IActionResult GetClientById(int id)
        {
            string connectionString = _configuration.GetConnectionString("PostgresConnection");

            using (var connection = new NpgsqlConnection(connectionString))
            {
                connection.Open();
                using (var command = new NpgsqlCommand("SELECT * FROM \"Main\".\"get_client_by_id\"(@id)", connection))
                {
                    command.Parameters.AddWithValue("Id", id);

                    using (var reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            var client = new ClientView
                            {
                                FirstName = reader["firstname"].ToString(),
                                LastName = reader["lastname"].ToString(),
                                Address = reader["address"].ToString(),
                                PhoneNumber = Convert.ToInt64(reader["phonenumber"]),
                                City_name = reader["city_name"].ToString(),
                                State_name  = reader["state_name"].ToString(),
                                Country_name = reader["country_name"].ToString()
                            };
                            return Ok(client);
                        }
                        else
                        {
                            return NotFound("Cliente no encontrado.");
                        }
                    }
                }
            }
        }

        [HttpPost]
        public IActionResult InsertClient([FromBody] ClientModel client)
        {
            if (client.PhoneNumber <= 0 || client.PhoneNumber.ToString().Length > 10)
            {
                return BadRequest("El número de teléfono debe ser un número valido y tener 10 dígitos o menos.");
            }

            if (client.City_id <= 0)
            {
                return BadRequest("El ID de la ciudad debe ser un número positivo.");
            }

            string connectionString = _configuration.GetConnectionString("PostgresConnection");

            using (var connection = new NpgsqlConnection(connectionString))
            {
                connection.Open();
                using (var command = new NpgsqlCommand("CALL \"Main\".insert_client(@FirstName, @LastName, @Address, @PhoneNumber, @City_id)", connection))
                {
                    command.Parameters.AddWithValue("FirstName", client.FirstName);
                    command.Parameters.AddWithValue("LastName", client.LastName);
                    command.Parameters.AddWithValue("Address", client.Address);
                    command.Parameters.AddWithValue("PhoneNumber", client.PhoneNumber);
                    command.Parameters.AddWithValue("City_id", client.City_id);

                    try
                    {
                        command.ExecuteNonQuery();
                        return Ok("Cliente insertado exitosamente.");
                    }
                    catch (PostgresException ex)
                    {
                        return BadRequest(ex.Message); 
                    }
                }
            }
        }
    }
}