
package ch.akros.marketplace.service.repository;

import java.util.List;

import ch.akros.marketplace.service.entity.FieldOption;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import ch.akros.marketplace.service.entity.Field;

@Repository
public interface FieldRepository extends JpaRepository<Field, Long> {
  @Query("select ft from field ft where ft.category.categoryId = :categoryId and ft.searchable=true order by sortNumber")
  List<Field> listCategorySearchFields(Long categoryId);

  @Query("select ft from field ft where ft.category.categoryId = :categoryId and (ft.request=:request or ft.offer!=:request) order by sortNumber")
  List<Field> listTopicSearchFields(Long categoryId, Boolean request);

  @Query("select op from fieldOption op where op.field.fieldId = :fieldId")
  List<FieldOption> listFieldOptions(Long fieldId);
}
