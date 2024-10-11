using Coink.Models;
using Microsoft.AspNetCore.Mvc;
using Npgsql;

namespace Coink.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class StateController : ControllerBase
    {
        private readonly IConfiguration _configuration;

        public StateController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        [HttpGet("{country_id}")]
        public IActionResult GetCitiesByState(int country_id)
        {
            string connectionString = _configuration.GetConnectionString("PostgresConnection");

            using (var connection = new NpgsqlConnection(connectionString))
            {
                connection.Open();
                string query = "SELECT * FROM \"Main\".\"get_states_by_country\"(" + country_id + ")";

                using (var command = new NpgsqlCommand(query, connection))
                {
                    using (var reader = command.ExecuteReader())
                    {
                        var cities = new List<Dictionary<string, object>>();
                        while (reader.Read())
                        {
                            var client = new Dictionary<string, object>();
                            for (int i = 0; i < reader.FieldCount; i++)
                            {
                                client[reader.GetName(i)] = reader.GetValue(i);
                            }
                            cities.Add(client);
                        }
                        return Ok(cities);
                    }
                }
            }
        }

        [HttpPost]
        public IActionResult InsertClient([FromBody] StateModel city)
        {
            string connectionString = _configuration.GetConnectionString("PostgresConnection");

            using (var connection = new NpgsqlConnection(connectionString))
            {
                connection.Open();
                using (var command = new NpgsqlCommand("CALL \"Main\".insert_state(@stateName, @countryId)", connection))
                {
                    command.Parameters.AddWithValue("stateName", city.StateName);
                    command.Parameters.AddWithValue("countryId", city.CountryId);
                    try
                    {
                        command.ExecuteNonQuery();
                        return Ok("Departamento insertado exitosamente.");
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