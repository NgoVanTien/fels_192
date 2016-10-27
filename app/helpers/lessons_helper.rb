module LessonsHelper
  def lesson_status lesson
    if lesson.is_finished?
      link_to t("view"), edit_category_lesson_path(lesson.category, lesson),
        class: "btn-flip btn btn-3d btn-success"
    else
      link_to t("start"),edit_category_lesson_path(lesson.category, lesson),
        class: "btn-flip btn btn-3d btn-primary"
    end
  end
end
