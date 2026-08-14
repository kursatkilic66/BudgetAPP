using Microsoft.AspNetCore.Mvc;
[ApiController]
[Route("api/[Controller]s")]
public class OtherCarOrderController : ControllerBase
{
    private readonly IUserDbContext _context;

    public OtherCarOrderController(IUserDbContext context)
    {
        _context = context;
    }
    [HttpPost]
    public async Task<IActionResult> Create([FromBody]CreateOtherCarOrderModel model)
    {
        CreateOtherCarOrderCommand vm = new CreateOtherCarOrderCommand(_context,model);
        await vm.Handle();
        return Ok();
    }
    [HttpPut("{id}")]
    public async Task<IActionResult> Update([FromBody]UpdateOtherCarOrderModel model,int id)
    {
        UpdateOtherCarOrderCommand vm = new UpdateOtherCarOrderCommand(_context,model,id);
       await vm.Handle();
       return Ok();
    }

    [HttpDelete("{id}")]
    public async Task<IActionResult> Delete(int id)
    {
        DeleteOtherCarOrderCommand vm = new DeleteOtherCarOrderCommand(_context,id);
        await vm.Handle();
        return Ok();
    }
    [HttpGet("{id}")]
    public async Task<IActionResult> Get(int id)
    {
        GetOtherCarOrderQuery vm = new GetOtherCarOrderQuery(_context,id);
       return Ok(await vm.Handle());
    }
    [HttpGet]
    public async Task<IActionResult> GetAll()
    {
        GetAllOtherCarOrderQuery vm = new GetAllOtherCarOrderQuery(_context);
        return Ok(await vm.Handle());
    }
}