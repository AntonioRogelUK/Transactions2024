using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SinTransaccion
{
    internal class VentaConcepto
    {
        public int Id { get; set; }
        public int VentaId { get; set; }
        public string? Descripcion { get; set; }
        public decimal PrecioUnitario { get; set; }
        public decimal Cantidad { get; set; }
        public decimal Importe { get; set; }
    }
}
