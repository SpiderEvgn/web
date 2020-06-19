class NewsController < ApplicationController
  def show
    @info = Info.find(params[:id])

    two_random_works = Work.pluck(:id).sample(2)
    @first_work = Work.find two_random_works[0]
    @second_work = Work.find two_random_works[1]

    info_id_in_sequence = Info.order(id: :desc).pluck(:id)
    previous_info_id = if info_id_in_sequence.first == @info.id
      info_id_in_sequence.last
    else
      info_id_in_sequence[info_id_in_sequence.index(@info.id) - 1]
    end

    next_info_id = if info_id_in_sequence.last == @info.id
      info_id_in_sequence.first
    else
      info_id_in_sequence[info_id_in_sequence.index(@info.id) + 1]
    end

    @previous_info = Info.find previous_info_id
    @next_info = Info.find next_info_id

  end

  def index
    @infos = Info.where(hide_in_index_news: false).order(position: :asc).page(params[:page]).per(params[:per_page])
  end
end
