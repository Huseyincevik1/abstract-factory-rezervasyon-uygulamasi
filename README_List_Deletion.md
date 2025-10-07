# List Deletion Scripts

Bu klasörde, `category_id = 8` olan kategoriye ait listeleri ve tüm ilişkili kayıtları silmek için iki farklı SQL script bulunmaktadır.

## Dosyalar

1. **`delete_lists_and_related_records.sql`** - Otomatik silme scripti
2. **`delete_lists_safe_version.sql`** - Güvenli versiyon (önce kontrol, sonra silme)

## Önemli Uyarılar ⚠️

- **Bu scriptler veriyi kalıcı olarak siler!**
- **Mutlaka veritabanı yedeği alın!**
- **Test ortamında önce deneyin!**
- **Production ortamında çalıştırmadan önce DBA ile görüşün!**

## Silinecek Tablolar

Script aşağıdaki tablolardan ilgili kayıtları siler:

1. `client_favourite_lists`
2. `collection_lists`
3. `discount_condition_lists`
4. `discount_lists`
5. `list_ai_reason`
6. `list_category_extra_information_answer`
7. `list_draft`
8. `list_image`
9. `list_personalizations`
10. `list_price_history`
11. `list_read_stats`
12. `list_read_stats_daily`
13. `list_regional_districts`
14. `list_stock_movements`
15. `lists_lang`
16. `list_category`
17. `lists` (ana tablo)

## Kullanım Talimatları

### Seçenek 1: Otomatik Script (`delete_lists_and_related_records.sql`)

Bu script tüm işlemi otomatik olarak yapar:

```sql
-- Scripti SQL Server Management Studio'da açın ve çalıştırın
-- Script şunları yapar:
-- 1. Silinecek list_id'leri geçici tabloda toplar
-- 2. Transaction başlatır
-- 3. Tüm ilişkili tabloları doğru sırada siler
-- 4. Hata varsa rollback yapar
-- 5. Başarılı ise commit yapar
```

**Avantajları:**
- Tek seferde tüm işlemi yapar
- Transaction kullanır (güvenli)
- Hata durumunda rollback yapar
- Her adımda kaç kayıt silindiğini gösterir

### Seçenek 2: Güvenli Script (`delete_lists_safe_version.sql`)

Bu script önce kontrol imkanı verir:

**Adım 1:** Önce hangi kayıtların silineceğini görmek için:
```sql
-- Script'in ilk bölümünü çalıştırın
-- Bu size şunları gösterir:
-- - Silinecek list_id'ler ve detayları
-- - Her tabloda kaç kayıt silineceği
```

**Adım 2:** Kontrol ettikten sonra silme işlemi için:
```sql
-- Script'in alt kısmındaki yorumları kaldırın ve çalıştırın
-- Bu gerçek silme işlemini yapar
```

**Avantajları:**
- Önce ne silineceğini görebilirsiniz
- Daha kontrollü yaklaşım
- İstenmeyen silmeleri önler

## Örnek Kullanım

### 1. İlk Kontrol
```sql
-- Hangi list_id'ler silinecek?
SELECT lc.list_id, l.list_stats_id
FROM lists l
INNER JOIN list_category lc ON l.id = lc.list_id
WHERE lc.category_id = 8;
```

### 2. Yedek Alma (Önerilen)
```sql
-- Önemli tabloların yedeğini alın
SELECT * INTO lists_backup_20241007 FROM lists 
WHERE id IN (
    SELECT lc.list_id 
    FROM list_category lc 
    WHERE lc.category_id = 8
);

-- Diğer tablolar için de benzer backup'lar alabilirsiniz
```

### 3. Script Çalıştırma
```sql
-- Seçtiğiniz scripti çalıştırın
-- Otomatik versiyon için: delete_lists_and_related_records.sql
-- Güvenli versiyon için: delete_lists_safe_version.sql
```

## Hata Durumları

Script aşağıdaki durumlarda hata verebilir:

1. **Foreign Key Constraint Hatası:** 
   - Script foreign key sırasını dikkate alır, bu nadir görülür
   - Eğer görülürse, eksik tablo var demektir

2. **Permission Hatası:**
   - DELETE yetkisi gereklidir
   - DBA'dan yetki isteyebilirsiniz

3. **Deadlock:**
   - Başka işlemler tabloları kullanıyorsa
   - Daha az yoğun saatte tekrar deneyin

## Doğrulama

Silme işlemi sonrası kontrol için:

```sql
-- Silme işlemi başarılı mı?
SELECT COUNT(*) as remaining_records
FROM lists l
INNER JOIN list_category lc ON l.id = lc.list_id
WHERE lc.category_id = 8;
-- Sonuç 0 olmalı

-- İlişkili tablolarda kalan kayıt var mı?
SELECT 'client_favourite_lists' as table_name, COUNT(*) as remaining
FROM client_favourite_lists cfl
WHERE cfl.list_id IN (SELECT id FROM lists WHERE id NOT IN (SELECT id FROM lists))
-- Bu sorgu da 0 döndürmeli (mantık kontrolü için)
```

## İletişim

Herhangi bir sorun durumunda:
- DBA ekibi ile iletişime geçin
- Script çalıştırmadan önce test ortamında deneyin
- Backup aldığınızdan emin olun

---

**Son Güncelleme:** 2024-10-07
**Script Versiyonu:** 1.0
**Uyumluluk:** SQL Server 2012+