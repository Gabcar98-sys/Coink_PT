using Coink.Models;
using Microsoft.AspNetCore.Mvc;
using Npgsql;

namespace Coink.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class CityController : ControllerBase
    {
        private readonly IConfiguration _configuration;

        public CityController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        [HttpGet("{state_id}")]
        public IActionResult GetCitiesByState(int state_id)
        {
            string connectionString = _configuration.GetConnectionString("PostgresConnection");

            using (var connection = new NpgsqlConnection(connectionString))
            {
                connection.Open();
                string query = "SELECT * FROM \"Main\".\"get_cities_by_state\"(" + state_id + ")";

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
        public IActionResult InsertClient([FromBody] CityModel city)
        {
            string connectionString = _configuration.GetConnectionString("PostgresConnection");

            using (var connection = new NpgsqlConnection(connectionString))
            {
                connection.Open();
                using (var command = new NpgsqlCommand("CALL \"Main\".insert_city(@cityName, @stateId)", connection))
                {
                    command.Parameters.AddWithValue("cityName", city.CityName);
                    command.Parameters.AddWithValue("stateId", city.StateId);
                    try
                    {
                        command.ExecuteNonQuery();
                        return Ok("Ciudad insertada exitosamente.");
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