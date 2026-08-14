using Microsoft.AspNetCore.Mvc;

[ApiController]
[Route("/api/[Controller]s")]
public class CarController : ControllerBase
{
    private readonly IUserDbContext _context;

    public CarController(IUserDbContext context)
    {
        _context = context;
    }

    [HttpPost]
    public async Task<IActionResult> Create([FromBody] CreateCarModel model)
    {
        CreateCarCommand vm = new CreateCarCommand(_context,model);
        await vm.Handle();
        return Ok();
    }
    [HttpPut("{id}")]
    public async Task<IActionResult> Update([FromBody]UpdateCarModel model,int id)
    {
        UpdateCarCommand vm = new UpdateCarCommand(_context,model,id);
        await vm.Handle();
        return Ok();
    }
    [HttpDelete("{id}")]
    public async Task<IActionResult> Delete(int id)
    {
        DeleteCarCommand vm = new DeleteCarCommand(_context,id);
        await vm.Handle();
        return Ok();
    } 
    [HttpPut("/passive/{id}")]
    public async Task<IActionResult> Passive(int id)
    {
        PassiveCarCommand vm = new PassiveCarCommand(_context,id);
        await vm.Handle();
        return Ok();
    }
    [HttpGet("{id}")]
    public async Task<IActionResult> Get(int id)
    {
        GetCarQuery vm = new GetCarQuery(_context,id);
        
        return Ok(await vm.Handle());
    }
    [HttpGet]
    public async Task<IActionResult> GetAll()
    {
        GetAllCarsQuery vm = new GetAllCarsQuery(_context);
        return Ok(await vm.Handle());
    }
}