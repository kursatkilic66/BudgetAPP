using Microsoft.AspNetCore.Mvc;
[ApiController]
[Route("/api/[Controller]s")]
public class ParkingOrderController : ControllerBase
{
    private readonly IUserDbContext _context;

    public ParkingOrderController(IUserDbContext context)
    {
        _context = context;
    }
    [HttpPost]
    public async Task<IActionResult> Create([FromBody]CreateParkingOrderModel model)
    {
        CreateParkingOrderCommand vm = new CreateParkingOrderCommand(_context,model);
        await vm.Handle();
        return Ok();
    }
    [HttpPut("{id}")]
    public async Task<IActionResult> Update([FromBody]UpdateParkingOrderModel model,int id)
    {
        UpdateParkingOrderCommand vm = new UpdateParkingOrderCommand(_context,model,id);
        await vm.Handle();
        return Ok();
    }
    [HttpDelete("{id}")]
    public async Task<IActionResult> Delete(int id)
    {
        DeleteParkingOrderCommand vm = new DeleteParkingOrderCommand(_context,id);
        await vm.Handle();
        return Ok();
    }
    [HttpGet("{id}")]
    public async Task<IActionResult> Get(int id)
    {
        GetParkingOrderQuery vm = new GetParkingOrderQuery(_context,id);
        return Ok(await vm.Handle());
    }
    [HttpGet]
    public async Task<IActionResult> GetAll()
    {
        GetAllParkingOrderQuery vm = new GetAllParkingOrderQuery(_context);
        return Ok(await vm.Handle());
    }
}