using Microsoft.AspNetCore.Mvc;
[ApiController]
[Route("/api/[Controller]s")]
public class FuelOrderController : ControllerBase
{
    private readonly IUserDbContext _context;

    public FuelOrderController(IUserDbContext context)
    {
        _context = context;
    }

    [HttpPost]
    public async Task<IActionResult> Create([FromBody]CreateFuelOrderModel model)
    {
        CreateFuelOrderCommand vm = new CreateFuelOrderCommand(_context,model);
        await vm.Handle();
        return Ok();
    }
    [HttpPut("{id}")]
    public async Task<IActionResult> Update([FromBody]UpdateFuelOrderModel model,int id)
    {
        UpdateFuelOrderCommand vm = new UpdateFuelOrderCommand(_context,model,id);
        await vm.Handle();
        return Ok();
    }
    [HttpDelete("{id}")]
    public async Task<IActionResult> Delete(int id)
    {
        DeleteFuelOrderCommand vm = new DeleteFuelOrderCommand(_context,id);
        await vm.Handle();
        return Ok();
    }
    [HttpGet("{id}")]
    public async Task<IActionResult> Get(int id)
    {
        GetFuelOrderQuery vm = new GetFuelOrderQuery(_context,id);
        return Ok(await vm.Handle());
    }
    [HttpGet]
    public async Task<IActionResult> GetAll()
    {
        GetAllFuelOrderQuery vm = new GetAllFuelOrderQuery(_context);
        return Ok(await vm.Handle());
    }

}