using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace yazılımmimarisi
{
    public class Istemci 
    {
        private  SoyutFabrika _SoyutFabrika;
        private  Ikonaklama _konaklama;
        private Iulasim _ulasim;

        public Istemci(SoyutFabrika soyutFabrika)
        {
            _SoyutFabrika = soyutFabrika;
            _konaklama = _SoyutFabrika.konaklamayarat();
            _ulasim = _SoyutFabrika.ulasimyarat();
        }

        public void Istemciistek()
        {
            _konaklama.konaklamaolustur();
            _ulasim.ulasimolustur();
        }

    }
}
