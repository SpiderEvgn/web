class LeadershipController < ApplicationController
  def index
    @search_name = params[:name].presence
    jituan_people = Person.includes(city_people: :city).where(cities: { name: '集团'})
      .where(leaving_date: nil).order(position: :asc)
    @management_people = if @search_name.present?
      jituan_people.joins('INNER JOIN person_translations ON person_translations.person_id = people.id')
        .where(category: 1).where('person_translations.name like ?', "%#{@search_name}%")
    else
      jituan_people.where(category: 1)
    end


    @speciality_people = if @search_name.present?
      jituan_people.joins('INNER JOIN person_translations ON person_translations.person_id = people.id')
        .where(category: 2).where('person_translations.name like ?', "%#{@search_name}%")
    else
      jituan_people.where(category: 2)
    end
  end

  def show
    @search_name = params[:name].presence
    city_area = City.find_by url_name: params[:id]
    if city_area.present?
      city_area_people = Person.includes(:city_people).where(city_people: { city_id: city_area.id })
        .where(leaving_date: nil)
        .order(position: :asc)
      @management_people = if @search_name.present?
        city_area_people.joins('INNER JOIN person_translations ON person_translations.person_id = people.id')
          .where(category: 1).where('person_translations.name like ?', "%#{@search_name}%")
      else
        city_area_people.where(category: 1)
      end

      @speciality_people = if @search_name.present?
        city_area_people.joins('INNER JOIN person_translations ON person_translations.person_id = people.id')
          .where(category: 2).where('person_translations.name like ?', "%#{@search_name}%")
      else
        city_area_people.where(category: 2)
      end
      render 'area_leadership', locals: { c: city_area.name, e: city_area.url_name.upcase }
    else
      @person = Person.where(leaving_date: nil).find_by(id: params[:id]) \
        || Person.where(leaving_date: nil).find_by!(url_name: params[:id])
      @infos = Info.order(position: :asc).where(hide_in_design_staff_news: false).limit(4)
      @infos = @infos.where('title LIKE ?', "%#{@person.name}%").or(@infos.where('content LIKE ?', "%#{@person.name}%"))
    end
  end
end
