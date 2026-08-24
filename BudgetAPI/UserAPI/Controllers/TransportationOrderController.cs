using Microsoft.AspNetCore.Mvc;
[ApiController]
[Route("/api/[Controller]s")]
public class TransportationOrderController : ControllerBase
{
    private readonly IUserDbContext _context;

    public TransportationOrderController(IUserDbContext context)
    {
        _context = context;
    }
    [HttpPost]
    public async Task<IActionResult> Create([FromBody]CreateTransportationOrderModel model)
    {
        CreateTransportationOrderCommand vm = new CreateTransportationOrderCommand(_context, model);
        await vm.Handle();
        return Ok();
    }
    [HttpPut("{id}")]
    public async Task<IActionResult> Update([FromBody] UpdateTransportationOrderModel model,int id)
    {
        UpdateTransportationOrderCommand vm = new UpdateTransportationOrderCommand(_context,model,id);
        await vm.Handle();
        return Ok();
    }
    [HttpDelete("{id}")]
    public async Task<IActionResult> Delete(int id)
    {
        DeleteTransportationOrderCommand vm = new DeleteTransportationOrderCommand(_context,id);
        await vm.Handle();
        return Ok();
    }
    [HttpGet("{id}")]
    public async Task<IActionResult> Get(int id)
    {
        GetTransportationOrderQuery vm = new GetTransportationOrderQuery(_context,id);
        return Ok(await vm.Handle());
    }
    [HttpGet]
    public async Task<IActionResult> GetAll()
    {
        GetAllTransportationOrderQuery vm = new GetAllTransportationOrderQuery(_context);
        return Ok(await vm.Handle());
    }

}