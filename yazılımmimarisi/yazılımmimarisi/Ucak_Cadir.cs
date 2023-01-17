using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace yazılımmimarisi
{
    public class Ucak_Cadir : SoyutFabrika
    {
        public override Ikonaklama konaklamayarat()
        {
            return new Cadir();
        }

        public override Iulasim ulasimyarat()
        {
            return new Ucak();
        }
    }
}
